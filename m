From: shawn.guo@freescale.com (Shawn Guo)
Date: Tue, 20 Dec 2011 23:31:03 +0800
Subject: [PATCH v3 1/3] mfd: mc13xxx: add device tree probe support
In-Reply-To: <20111220143558.GT2866@opensource.wolfsonmicro.com>
References: <1323702958-4831-1-git-send-email-shawn.guo@linaro.org>
 <1323702958-4831-2-git-send-email-shawn.guo@linaro.org>
 <20111220005708.GM2860@opensource.wolfsonmicro.com>
 <20111220020101.GD5683@S2100-06.ap.freescale.net>
 <20111220015931.GX2860@opensource.wolfsonmicro.com>
 <20111220030347.GB2995@S2101-09.ap.freescale.net>
 <20111220112510.GL2866@opensource.wolfsonmicro.com>
 <20111220135251.GB5129@S2101-09.ap.freescale.net>
 <20111220143558.GT2866@opensource.wolfsonmicro.com>
Message-ID: <20111220153101.GD5348@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 02:35:58PM +0000, Mark Brown wrote:
> On Tue, Dec 20, 2011 at 09:52:52PM +0800, Shawn Guo wrote:
> > On Tue, Dec 20, 2011 at 11:25:11AM +0000, Mark Brown wrote:
> 
> > > Well, removing the random extra _s would be a big start (though I'd just
> > > drop the chip name entirely from the name of the regulators since by the
> > > time we're looking at the regulator we've already identified the chip)
> > > and as I keep saying you need to document what the names mean - what are
> > > the possible names and how do they map onto the hardware?
> 
> > I just came up with an idea which can totally avoid matching name.  It
> > seems that we can identify a regulator using register plus enable bit,
> > which is basically 'reg' and 'enable_bit' in 'mc13xxx_regulator'.  As
> > these data must be coming from hardware manual, they should be stable
> > enough for binding a regulator.  What do you think?
> 
> I don't know that that helps, register numbers and shifts aren't going
> to do anything for legibility.

I think it helps.  It's not about legibility but identification.  For
mc13892 driver to work, it has to match the register number and enable
bit shift given by mc13892 reference manual.  So register number +
enable bit shift is stable and unique to identify a mc13892 regulator.

> The problem with the names was that the
> names chosen were poorly defined (why call DCDCn chipname__dcdcn?) and
> not documented in the binding, not that they were names.
> 
The problem with name is it's name.  The mc13892 driver can still work
with naming regulator differently from mc13892 reference manual.  So
using name to bind a regulator means we are binding with Linux mc13892
driver.  In that case, DT probe works if and only if the name in dts
matches the name used in mc13892 driver, and it does not work as long
as the name dts does not match the name used in mc13892 driver.

Yes, I flipped and now think using name to bind is a bad idea, no
matter how we document it.

-- 
Regards,
Shawn
