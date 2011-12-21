From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 21 Dec 2011 09:25:21 +0800
Subject: [PATCH v3 1/3] mfd: mc13xxx: add device tree probe support
In-Reply-To: <20111220232526.GA6551@opensource.wolfsonmicro.com>
References: <1323702958-4831-2-git-send-email-shawn.guo@linaro.org>
 <20111220005708.GM2860@opensource.wolfsonmicro.com>
 <20111220020101.GD5683@S2100-06.ap.freescale.net>
 <20111220015931.GX2860@opensource.wolfsonmicro.com>
 <20111220030347.GB2995@S2101-09.ap.freescale.net>
 <20111220112510.GL2866@opensource.wolfsonmicro.com>
 <20111220135251.GB5129@S2101-09.ap.freescale.net>
 <20111220143558.GT2866@opensource.wolfsonmicro.com>
 <20111220153101.GD5348@S2101-09.ap.freescale.net>
 <20111220232526.GA6551@opensource.wolfsonmicro.com>
Message-ID: <20111221012519.GA5983@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 20, 2011 at 11:25:27PM +0000, Mark Brown wrote:
> On Tue, Dec 20, 2011 at 11:31:03PM +0800, Shawn Guo wrote:
> > On Tue, Dec 20, 2011 at 02:35:58PM +0000, Mark Brown wrote:
> 
> > > I don't know that that helps, register numbers and shifts aren't going
> > > to do anything for legibility.
> 
> > I think it helps.  It's not about legibility but identification.  For
> > mc13892 driver to work, it has to match the register number and enable
> > bit shift given by mc13892 reference manual.  So register number +
> > enable bit shift is stable and unique to identify a mc13892 regulator.
> 
> It's unique but I feel the disadvantages in terms of legibility of the
> resulting device trees are substantial - we want humans to be able to
> read and write device trees, preferrably without having to dig out the
> datasheet for the part.

Eh, device tree is all about describing hardware.  I do not understand
what is wrong with looking at hardware manual when writing dts.

> So long as the names are reasonably sensible
> and can be understood in the case of any lack of clarity we should be
> OK.
> 
The problem is even if we have the name defined that way, it has to be
matched to the name used in mc13892 driver somehow, if we want to use
name as the key to find the regulator defined in mc13892 driver as
array mc13892_regulators[].

> > > The problem with the names was that the
> > > names chosen were poorly defined (why call DCDCn chipname__dcdcn?) and
> > > not documented in the binding, not that they were names.
> 
> > The problem with name is it's name.  The mc13892 driver can still work
> > with naming regulator differently from mc13892 reference manual.  So
> > using name to bind a regulator means we are binding with Linux mc13892
> > driver.  In that case, DT probe works if and only if the name in dts
> > matches the name used in mc13892 driver, and it does not work as long
> > as the name dts does not match the name used in mc13892 driver.
> 
> This is the whole reason why I'm saying that you need to define the
> names used in the binding - if the names are a defined part of the
> binding then there's nothing driver specific about them.
> 
Can you please help me understand how this can be achieved with an
example?  Taking 'mc13892__sw1' as the example, if I read your comment
before correctly, 'sw1' is the name that you are suggesting.  How this
name can be nothing driver specific?  After all, we need to find
regulator MC13892_SW1 defined in mc13892_regulators[] by matching name
'sw1' defined by binding and name 'MC13892_SW1' defined by driver
somehow, if we want to use name to bind the regulator.

I feel I might miss your point again.  So please help clarify.

-- 
Regards,
Shawn
