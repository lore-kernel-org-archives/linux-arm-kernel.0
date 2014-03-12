From: broonie@kernel.org (Mark Brown)
Date: Wed, 12 Mar 2014 00:38:58 +0000
Subject: [linux-sunxi] Re: [PATCH 6/7] regulator: AXP20x: Add support for
 regulators subsystem
In-Reply-To: <20140311210659.GA10961@localhost.fastwebnet.it>
References: <1393692352-10839-1-git-send-email-carlo@caione.org>
 <1393692352-10839-7-git-send-email-carlo@caione.org>
 <20140303015616.GN2411@sirena.org.uk>
 <20140311192411.GA4193@localhost.fastwebnet.it>
 <20140311192940.GA28112@sirena.org.uk>
 <20140311210659.GA10961@localhost.fastwebnet.it>
Message-ID: <20140312003858.GG28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 11, 2014 at 10:06:59PM +0100, Carlo Caione wrote:
> On Tue, Mar 11, 2014 at 07:29:40PM +0000, Mark Brown wrote:

> > With the above code the driver will return an error and never get as far
> > as registering the regulator.

> I agree, but if I register the regulators without having the constrains
> defined in the DT, when regulator_init_complete() is
> called, the regulators are disabled powering off the SoC (at least for
> DCDC2 and DCDC3).

Right, but the kernel will say what it's doing before it does so and
then the user can provide the appropriate setup in DT to force things
on.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140312/816efa6f/attachment.sig>
