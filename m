From: broonie@kernel.org (Mark Brown)
Date: Fri, 5 Jul 2013 15:08:28 +0100
Subject: [RFC PATCH V2 1/8] regulator: Introduce OMAP regulator to
 control PMIC over VC/VP
In-Reply-To: <20130705135507.GA17439@kahuna>
References: <1371849949-12649-1-git-send-email-nm@ti.com>
 <1371849949-12649-2-git-send-email-nm@ti.com>
 <20130704154105.GD27646@sirena.org.uk>
 <20130705135507.GA17439@kahuna>
Message-ID: <20130705140828.GA27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 05, 2013 at 08:55:07AM -0500, Nishanth Menon wrote:

Please write in paragraphs, an enormous wall of unbroken text isn't
helpful for legibility.

> On 16:41-20130704, Mark Brown wrote:

> > So, this still has the thing where all the data about the PMIC is
> > replicated (but now in this driver).  It should be possible to pull all
> > the above information except possibly the I2C timeout and perhaps the
> > I2C address (if there's a separate control interface) from the standard
> > regulator core data structures for the PMIC.  This would allow the
> > driver to Just Work with any PMIC without needing to add it in two
> > places.

> option 1) we just bypass get_voltage/set_voltage to point through to
> this function. result will be something similar to what we got here[1]

I don't really know what you mean when you say "bypass get_voltage/set_voltage
so it's kind of hard to comment...  the link you posted appears to be a
link to the code I'm reviewing so it's not terribly enlightening.

> Again, based on this discussion, it is wrong - and we already did implement
> the *wrong* way in OMAP and the new code is supposed to throw away the
> old code once all relevant platforms are converted to DT.
> - now, we could improve this by passing rdev and slurp out required
>  data from regulator structures, but obviously, as you pointed out, it wont
>  be sufficient.
> - In this solution, we will have existing regulator drivers supporting
> additional data path. *but* that also means that existing regulator
> drivers will need to be modified to handle multiple data path and "Just
> Work" wont happen - so not really good other than screw up existing
> regulator drivers with handling OMAP specific APIs in them.

What makes you think that the existing regulator drivers need to be
modified?  They already have all the data exported to the core (or
should do)...  the only thing that's missing is the timeouts and it's
not at all obvious why those need to be tuned per device.

> option 2) make omap_pmic regulator use twl_regulator - regulator
> chaining.

Again I don't know what this is.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130705/37daebf2/attachment.sig>
