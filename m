From: gautamvivek1987@gmail.com (Vivek Gautam)
Date: Sat, 28 Jul 2012 16:05:34 -0000
Subject: [PATCH 2/8 v2] ARM: EXYNOS5: Add machine data for USB 2.0
In-Reply-To: <201207261124.50141.arnd@arndb.de>
References: <1342866729-30460-1-git-send-email-gautam.vivek@samsung.com>
 <1342866729-30460-3-git-send-email-gautam.vivek@samsung.com>
 <201207261124.50141.arnd@arndb.de>
Message-ID: <CAFp+6iH0c=LogUXnpg0pD05X+mMGP9XiWDDxiTyNQAxJq_srJg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 26, 2012 at 8:24 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Saturday 21 July 2012, Vivek Gautam wrote:
> > From: Ajay Kumar <ajaykumar.rs@samsung.com>
> >
> > This patch adds address mapping of USB 2.0 PHY for exynos5
> >
> > Signed-off-by: Ajay Kumar <ajaykumar.rs@samsung.com>
> > Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> > ---
> >  arch/arm/mach-exynos/common.c           |    5 +++++
> >  arch/arm/mach-exynos/include/mach/map.h |    2 ++
> >  2 files changed, 7 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/arm/mach-exynos/common.c
> b/arch/arm/mach-exynos/common.c
> > index 4eb39cd..92d5e61 100644
> > --- a/arch/arm/mach-exynos/common.c
> > +++ b/arch/arm/mach-exynos/common.c
> > @@ -275,6 +275,11 @@ static struct map_desc exynos5_iodesc[] __initdata
> = {
> >                 .pfn            = __phys_to_pfn(EXYNOS5_PA_GIC_DIST),
> >                 .length         = SZ_4K,
> >                 .type           = MT_DEVICE,
> > +       }, {
> > +               .virtual        = (unsigned long)S3C_VA_USB_HSPHY,
> > +               .pfn            = __phys_to_pfn(EXYNOS5_PA_USB_PHY),
> > +               .length         = SZ_4K,
> > +               .type           = MT_DEVICE,
> >         },
> >  };
>
> Can you pleae explain why this is done in the changelog?
>
> We try hard to do such mappings from the device driver instead,
> so I'm surprised that this is necessary fo rthe USB phy.
>

We are doing the mapping for device address in the driver, but this memory
mapping for USB PHY registers that need to be programmed by the software
is done here. This is similar to what we see for exynos4 also. Is it
something
that i can still change? Please suggest.

>
>         Arnd
>
> _______________________________________________
> devicetree-discuss mailing list
> devicetree-discuss at lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/devicetree-discuss
>

Best regards
Vivek
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120728/842f34d8/attachment.html>
