From: jgq516@gmail.com (Xiao Jiang)
Date: Sat, 7 Jul 2012 07:15:38 +0800
Subject: [PATCH 1/1] ARM: add PROC_DEVICETREE support in Kconfig
In-Reply-To: <4FF6DCCA.2080509@gmail.com>
References: <1341571127-14461-1-git-send-email-jgq516@gmail.com>
 <4FF6DCCA.2080509@gmail.com>
Message-ID: <CAERv70uZMEoX4OcECssOrktVzC911tiSLXRH56TjyhQqVgNwBA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/7/6 Rob Herring <robherring2@gmail.com>

> On 07/06/2012 05:38 AM, jgq516 at gmail.com wrote:
> > From: Xiao Jiang <jgq516@gmail.com>
> >
> > Since more and more arm chips support device tree, it'd be better add
> PROC_DEVICETREE
> > in arch/arm/Kconfig to avoid duplicate code.
>
> I think this should remain user choice. If its going to be selected,
> then you might as well just remove the option altogether. Perhaps just
> make the option default to yes.
>
> Hmm, sounds reasonable from your point. So the better choice is to set the
option default to Y if the board has dt support just like tegra_defconfig
and at91_dt_defconfig,  right? thanks.

Regards,
Xiao

Rob
>
> > Signed-off-by: Xiao Jiang <jgq516@gmail.com>
> > ---
> >  arch/arm/Kconfig                   |    1 +
> >  arch/arm/configs/at91_dt_defconfig |    1 -
> >  arch/arm/configs/tegra_defconfig   |    1 -
> >  arch/arm/plat-omap/Kconfig         |    1 -
> >  4 files changed, 1 insertions(+), 3 deletions(-)
> >
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index a91009c..f68896e 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -1864,6 +1864,7 @@ config USE_OF
> >       select OF
> >       select OF_EARLY_FLATTREE
> >       select IRQ_DOMAIN
> > +     select PROC_DEVICETREE if PROC_FS
> >       help
> >         Include support for flattened device tree machine descriptions.
> >
> > diff --git a/arch/arm/configs/at91_dt_defconfig
> b/arch/arm/configs/at91_dt_defconfig
> > index 67bc571..b856cb6 100644
> > --- a/arch/arm/configs/at91_dt_defconfig
> > +++ b/arch/arm/configs/at91_dt_defconfig
> > @@ -64,7 +64,6 @@ CONFIG_MTD_NAND=y
> >  CONFIG_MTD_NAND_ATMEL=y
> >  CONFIG_MTD_UBI=y
> >  CONFIG_MTD_UBI_GLUEBI=y
> > -CONFIG_PROC_DEVICETREE=y
> >  CONFIG_BLK_DEV_LOOP=y
> >  CONFIG_BLK_DEV_RAM=y
> >  CONFIG_BLK_DEV_RAM_COUNT=4
> > diff --git a/arch/arm/configs/tegra_defconfig
> b/arch/arm/configs/tegra_defconfig
> > index 1198dd6..43e7b65 100644
> > --- a/arch/arm/configs/tegra_defconfig
> > +++ b/arch/arm/configs/tegra_defconfig
> > @@ -72,7 +72,6 @@ CONFIG_IPV6_TUNNEL=y
> >  CONFIG_IPV6_MULTIPLE_TABLES=y
> >  # CONFIG_WIRELESS is not set
> >  # CONFIG_FIRMWARE_IN_KERNEL is not set
> > -CONFIG_PROC_DEVICETREE=y
> >  CONFIG_BLK_DEV_LOOP=y
> >  CONFIG_AD525X_DPOT=y
> >  CONFIG_AD525X_DPOT_I2C=y
> > diff --git a/arch/arm/plat-omap/Kconfig b/arch/arm/plat-omap/Kconfig
> > index ad95c7a..4e2cb17 100644
> > --- a/arch/arm/plat-omap/Kconfig
> > +++ b/arch/arm/plat-omap/Kconfig
> > @@ -27,7 +27,6 @@ config ARCH_OMAP2PLUS
> >       select GENERIC_IRQ_CHIP
> >       select OMAP_DM_TIMER
> >       select USE_OF
> > -     select PROC_DEVICETREE if PROC_FS
> >       help
> >         "Systems based on OMAP2, OMAP3 or OMAP4"
> >
> >
>
>
>
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120707/d56f2dbc/attachment-0001.html>
