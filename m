From: rurality.linux@gmail.com (Wang Qiang)
Date: Tue, 5 Jan 2010 12:02:16 +0900
Subject: [PATCH] NUC900: Add extern header file support for some driver
In-Reply-To: <e68bb3471001041843s57085e98v324f977e6ae9f9c1@mail.gmail.com>
References: <4B3F69ED.2030404@gmail.com>
	<20100104165827.GB14533@n2100.arm.linux.org.uk>
	<ae11f36b1001041826m2dea49dfvc0511aa9e1783ba9@mail.gmail.com>
	<e68bb3471001041843s57085e98v324f977e6ae9f9c1@mail.gmail.com>
Message-ID: <ae11f36b1001041902m6f424b84k49a0f564a1ff527d@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 5, 2010 at 11:43 AM, Wan ZongShun <mcuos.com@gmail.com> wrote:

> 2010/1/5 ?? <rurality.linux@gmail.com>:
> >
> >
> > 2010/1/5 Russell King - ARM Linux <linux@arm.linux.org.uk>
> >>
> >> On Sat, Jan 02, 2010 at 11:44:45PM +0800, Wan ZongShun wrote:
> >> > Dear Wang Qiang,
> >> >
> >> > This patch provides a API for your LCD driver or other drivers, if you
> >> > want to use those APIs, please include corresponding header file.
> >> >
> >> > Signed-off-by: Wan ZongShun <mcuos.com@gmail.com>
> >> > ---
> >> >  arch/arm/mach-w90x900/include/mach/clkdev.h |    3 +++
> >> >  arch/arm/mach-w90x900/include/mach/mfp.h    |   23
> >> > +++++++++++++++++++++++
> >> >  2 files changed, 26 insertions(+), 0 deletions(-)
> >> >  create mode 100644 arch/arm/mach-w90x900/include/mach/mfp.h
> >> >
> >> > diff --git a/arch/arm/mach-w90x900/include/mach/clkdev.h
> >> > b/arch/arm/mach-w90x900/include/mach/clkdev.h
> >> > index 04b37a8..b35f4bc 100644
> >> > --- a/arch/arm/mach-w90x900/include/mach/clkdev.h
> >> > +++ b/arch/arm/mach-w90x900/include/mach/clkdev.h
> >> > @@ -4,4 +4,7 @@
> >> >  #define __clk_get(clk) ({ 1; })
> >> >  #define __clk_put(clk) do { } while (0)
> >> >
> >> > +extern void nuc900_driver_clksrc_div(struct device *dev, unsigned
> char
> >> > *src,
> >> > +                                                     unsigned char
> >> > divider);
> >> > +
> >>
> >> I'd prefer it if this header didn't get used for non-clkdev<->plat code
> >> stuff.
> >
> > So, you mean I can use this header in the LCD driver of nuc900 plat?
> >
>
> Hmmm, I don't think so.
>
> I think it is better to implement other API as Ben Dooks mentioned,
> but if you want to use
> this API provided by me, we have to add the extern to other header
> file rather than the specific clkdev header file.
>
> So, please wait me for new patch.


Ok, thank you.
I can not display the Linux Logo correctly.
I debug the kernel, it gave the wrong size of logo cols x rows = 40 x 15.
Any Idea?
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20100105/d911113b/attachment-0001.htm>
