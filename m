From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 8 May 2012 10:01:46 +0100
Subject: common clock framework
In-Reply-To: <CAJOA=zPozuanQFWt10PU4mySQ1kV+YV6iO5+BOfDWGPS2Y0aYg@mail.gmail.com>
References: <AAD1C6EB06EE3649B35B7E026785068D1A74A94270@SC-VEXCH2.marvell.com>
 <20120504082110.GB16535@pengutronix.de>
 <CAJOA=zOs8FLTRUh=LOd2f=YxFz7Sdxgp2JJurpQkdDFALcCiVw@mail.gmail.com>
 <20120505082840.GQ4141@pengutronix.de>
 <CAJOA=zPozuanQFWt10PU4mySQ1kV+YV6iO5+BOfDWGPS2Y0aYg@mail.gmail.com>
Message-ID: <20120508090145.GG15893@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 05, 2012 at 10:44:17AM -0700, Turquette, Mike wrote:
> + Mark & Graeme (for audio/pmic perspective)

> >> Having clk_set_rate and clk_prepare both hold the same prepare_lock
> >> mutex seems suboptimal, but it is easy. ?Having reentrant accesses to
> >> the clock tree is going to be hard... ?I've spent some time thinking
> >> of ways to solve this, but I would appreciate suggestions. ?I suspect
> >> the exact same case I'm describing above will affect many SoCs.

> > That's interesting. Here's another one: What will happen when Mark
> > attaches one of his i2c wolfson chips to a omap core and wants to test
> > his new clock driver? a clk_prepare on some clock on the wolfson chip
> > will trigger another clk_prepare inside the i2c driver.
> > So the reentrancy problem is not limited to prepare vs. set_rate.

This sounds pretty much expected - you'll also see similar things on
some SoCs where IPs for clocks might get clock gated when not in use and
reentrancy could crop up while exiting low power modes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120508/d985f537/attachment.sig>
