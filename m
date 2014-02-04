From: broonie@kernel.org (Mark Brown)
Date: Tue, 4 Feb 2014 20:11:22 +0000
Subject: Extending OPP bindings
In-Reply-To: <52F13F54.5060000@ti.com>
References: <52EA570A.8040501@arm.com> <52EAF1CA.3040702@ti.com>
 <20140131124620.GC2616@e102568-lin.cambridge.arm.com>
 <CAL_Jsq+Kq9C39xr9tY8gSX+6QFkNDqwmTyC+dBhLNcxKMweCpw@mail.gmail.com>
 <20140131180929.GH2616@e102568-lin.cambridge.arm.com>
 <52F12AE7.904@ti.com> <20140204182220.GQ22609@sirena.org.uk>
 <52F13F54.5060000@ti.com>
Message-ID: <20140204201122.GB22609@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 04, 2014 at 01:28:20PM -0600, Nishanth Menon wrote:
> On 02/04/2014 12:22 PM, Mark Brown wrote:

> > You're assuming that the frequency is a unique key here.  That may not
> > be the case, for example two OPPs might have the same CPU clock
> > (assuming that's the frequency you're referring to) but different bus
> > clocking and of course the CPUs or CPU clusters might be individually
> > scalable (this is common in big.LITTLE designs I think).

> Which is why OPPs are maintained per device, bus OPPs belong to bus
> device (in TI terminology, we'd be talking of cross domain dependency
> here for maintaining asynchronous bridge timing closure constraints -
> but ofcourse, other SoCs may or maynot have such constraints). For
> scaling bus frequency, we already have infrastructure in place - clock
> notifiers - discussion of using that is much deeper topic of it's own.

> for each processor that is uniquely transitioning, we'd have it's own
> sets of OPPs - the correct representation of the device node is the
> key there.

I've seen some SoCs characterised over the whole device rather than with
individual parts of the SoC done separately.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140204/90067f8e/attachment.sig>
