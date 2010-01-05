From: rurality.linux@gmail.com (=?GB2312?B?zfXHvw==?=)
Date: Tue, 5 Jan 2010 11:26:13 +0900
Subject: [PATCH] NUC900: Add extern header file support for some driver
In-Reply-To: <20100104165827.GB14533@n2100.arm.linux.org.uk>
References: <4B3F69ED.2030404@gmail.com>
	<20100104165827.GB14533@n2100.arm.linux.org.uk>
Message-ID: <ae11f36b1001041826m2dea49dfvc0511aa9e1783ba9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/1/5 Russell King - ARM Linux <linux@arm.linux.org.uk>

> On Sat, Jan 02, 2010 at 11:44:45PM +0800, Wan ZongShun wrote:
> > Dear Wang Qiang,
> >
> > This patch provides a API for your LCD driver or other drivers, if you
> > want to use those APIs, please include corresponding header file.
> >
> > Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> > ---
> >  arch/arm/mach-w90x900/include/mach/clkdev.h |    3 +++
> >  arch/arm/mach-w90x900/include/mach/mfp.h    |   23
> +++++++++++++++++++++++
> >  2 files changed, 26 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm/mach-w90x900/include/mach/mfp.h
> >
> > diff --git a/arch/arm/mach-w90x900/include/mach/clkdev.h
> > b/arch/arm/mach-w90x900/include/mach/clkdev.h
> > index 04b37a8..b35f4bc 100644
> > --- a/arch/arm/mach-w90x900/include/mach/clkdev.h
> > +++ b/arch/arm/mach-w90x900/include/mach/clkdev.h
> > @@ -4,4 +4,7 @@
> >  #define __clk_get(clk) ({ 1; })
> >  #define __clk_put(clk) do { } while (0)
> >
> > +extern void nuc900_driver_clksrc_div(struct device *dev, unsigned char
> > *src,
> > +                                                     unsigned char
> divider);
> > +
>
> I'd prefer it if this header didn't get used for non-clkdev<->plat code
> stuff.


So, you mean I can use this header in the LCD driver of nuc900 plat?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100105/90efb3e7/attachment-0001.htm>
