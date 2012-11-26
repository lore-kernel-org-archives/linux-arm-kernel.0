From: anilkumar@ti.com (AnilKumar, Chimata)
Date: Mon, 26 Nov 2012 05:54:18 +0000
Subject: [PATCH v3 5/5] ARM: OMAP2+: omap2plus_defconfig: Enable RTC
 support
In-Reply-To: <50AFAA6B.9020706@gmail.com>
References: <1353404927-14412-1-git-send-email-anilkumar@ti.com>
 <1353404927-14412-6-git-send-email-anilkumar@ti.com>
 <50AFAA6B.9020706@gmail.com>
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EA7A4B7@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 23, 2012 at 22:25:07, Igor Mazanov wrote:
> AnilKumar Ch wrote:
> > AM33XX family of devices uses RTC module, one has to manually enable
> > this support to use RTC features. So this patch enable RTC driver in
> > omap2plus_defconfig.
> > 
> > Signed-off-by: AnilKumar Ch <anilkumar-l0cyMroinI0@public.gmane.org>
> > ---
> >  arch/arm/configs/omap2plus_defconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > diff --git a/arch/arm/configs/omap2plus_defconfig b/arch/arm/configs/omap2plus_defconfig
> > index a4b330e..8839ac9 100644
> > --- a/arch/arm/configs/omap2plus_defconfig
> > +++ b/arch/arm/configs/omap2plus_defconfig
> > @@ -194,6 +194,7 @@ CONFIG_SDIO_UART=y
> >  CONFIG_MMC_OMAP=y
> >  CONFIG_MMC_OMAP_HS=y
> >  CONFIG_RTC_CLASS=y
> > +CONFIG_RTC_DRV_OMAP=y
> >  CONFIG_RTC_DRV_TWL92330=y
> >  CONFIG_RTC_DRV_TWL4030=y
> >  CONFIG_DMADEVICES=y
> 
> Hello,
> 
> But this is not enough, we need to change drivers/rtc/Kconfig too. This change 
> was offered in this thread
> 
> http://marc.info/?l=linux-arm-kernel&m=135057569913027&w=2
> 
> But, may be all this previous rtc-related changes accounted already in some 
> development branch. I just doesn't see it in the current master. In this case, 
> when could we get RTC support in the current kernel?

The Kconfig modification already present in mainline (linux-next/master)

Thanks
AnilKumar
