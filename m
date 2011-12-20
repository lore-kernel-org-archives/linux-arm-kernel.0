From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 23:25:27 +0000
Subject: [PATCH v3 1/3] mfd: mc13xxx: add device tree probe support
In-Reply-To: <20111220153101.GD5348@S2101-09.ap.freescale.net>
References: <1323702958-4831-1-git-send-email-shawn.guo@linaro.org>
 <1323702958-4831-2-git-send-email-shawn.guo@linaro.org>
 <20111220005708.GM2860@opensource.wolfsonmicro.com>
 <20111220020101.GD5683@S2100-06.ap.freescale.net>
 <20111220015931.GX2860@opensource.wolfsonmicro.com>
 <20111220030347.GB2995@S2101-09.ap.freescale.net>
 <20111220112510.GL2866@opensource.wolfsonmicro.com>
 <20111220135251.GB5129@S2101-09.ap.freescale.net>
 <20111220143558.GT2866@opensource.wolfsonmicro.com>
 <20111220153101.GD5348@S2101-09.ap.freescale.net>
Message-ID: <20111220232526.GA6551@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 11:31:03PM +0800, Shawn Guo wrote:
> On Tue, Dec 20, 2011 at 02:35:58PM +0000, Mark Brown wrote:

> > I don't know that that helps, register numbers and shifts aren't going
> > to do anything for legibility.

> I think it helps.  It's not about legibility but identification.  For
> mc13892 driver to work, it has to match the register number and enable
> bit shift given by mc13892 reference manual.  So register number +
> enable bit shift is stable and unique to identify a mc13892 regulator.

It's unique but I feel the disadvantages in terms of legibility of the
resulting device trees are substantial - we want humans to be able to
read and write device trees, preferrably without having to dig out the
datasheet for the part.  So long as the names are reasonably sensible
and can be understood in the case of any lack of clarity we should be
OK.

> > The problem with the names was that the
> > names chosen were poorly defined (why call DCDCn chipname__dcdcn?) and
> > not documented in the binding, not that they were names.

> The problem with name is it's name.  The mc13892 driver can still work
> with naming regulator differently from mc13892 reference manual.  So
> using name to bind a regulator means we are binding with Linux mc13892
> driver.  In that case, DT probe works if and only if the name in dts
> matches the name used in mc13892 driver, and it does not work as long
> as the name dts does not match the name used in mc13892 driver.

This is the whole reason why I'm saying that you need to define the
names used in the binding - if the names are a defined part of the
binding then there's nothing driver specific about them.
