From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 26 Jun 2013 17:01:36 +0200 (CEST)
Subject: [linux-next PATCH] ARM: shmobile: marzen: defconfig: enable DMA
 engine support
In-Reply-To: <20130626145252.GA4748@verge.net.au>
References: <1642514.quKgForQrD@amdc1032> <20130626145252.GA4748@verge.net.au>
Message-ID: <Pine.LNX.4.64.1306261700130.8856@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Wed, 26 Jun 2013, Simon Horman wrote:

> [ Cc linux-sh and Guennadi ]
> 
> I have not looked into this closely but it seems to me that
> it would be more robust to resolve this problem using Kconfig.

I still think this

https://patchwork.kernel.org/patch/2640051/

is a proper fix. We cannot and do not want to force building shdma on all 
platforms, where SDHI or any other potential shdma client is built. It is 
perfectly valid to build SDHI with no DMA support, which is exactly what 
that patch makes possible.

Thanks
Guennadi

> 
> On Wed, Jun 26, 2013 at 12:02:55PM +0200, Bartlomiej Zolnierkiewicz wrote:
> > From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > Subject: [linux-next PATCH] ARM: shmobile: marzen: defconfig: enable DMA engine support
> > 
> > Building marzen_defconfig for next-20130626 results in the following
> > build error:
> > 
> > drivers/built-in.o: In function `sh_mobile_sdhi_probe':
> > /home/bzolnier/sam/linux-sprc/drivers/mmc/host/sh_mobile_sdhi.c:170: undefined reference to `shdma_chan_filter'
> > 
> > Fix it by adding CONFIG_DMADEVICES=y line to marzen_defconfig. This
> > will result in CONFIG_SH_DMAE_BASE being enabled by default and the
> > needed code being build.
> > 
> > Cc: Stephen Rothwell <sfr@canb.auug.org.au>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> > Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> > ---
> >  arch/arm/configs/marzen_defconfig |    1 +
> >  1 file changed, 1 insertion(+)
> > 
> > Index: b/arch/arm/configs/marzen_defconfig
> > ===================================================================
> > --- a/arch/arm/configs/marzen_defconfig	2013-06-21 12:04:24.813681807 +0200
> > +++ b/arch/arm/configs/marzen_defconfig	2013-06-25 16:43:40.730367398 +0200
> > @@ -96,6 +96,7 @@ CONFIG_USB_STORAGE=y
> >  CONFIG_NEW_LEDS=y
> >  CONFIG_LEDS_CLASS=y
> >  CONFIG_LEDS_GPIO=y
> > +CONFIG_DMADEVICES=y
> >  CONFIG_UIO=y
> >  CONFIG_UIO_PDRV_GENIRQ=y
> >  # CONFIG_IOMMU_SUPPORT is not set
> > 
> 

---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
