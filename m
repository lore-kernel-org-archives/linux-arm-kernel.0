From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Wed, 8 Aug 2012 15:00:20 +0200
Subject: [PATCH 6/6] ARM: imx: gpmi-nand depends on mxs-dma
In-Reply-To: <1344430493-5304-7-git-send-email-arnd@arndb.de>
References: <1344430493-5304-1-git-send-email-arnd@arndb.de>
 <1344430493-5304-7-git-send-email-arnd@arndb.de>
Message-ID: <502262E4.9020303@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08.08.2012 14:54, Arnd Bergmann wrote:
> It is not currently possible to build the gpmi-nand driver without
> also building the mxs-dma driver. Clarify this Kconfig and enable
> both in the defconfig file so we can build it again with both enabled.
> 
> drivers/built-in.o: In function `gpmi_dma_filter':
> clk-fixed-factor.c:(.text+0xafc18): undefined reference to `mxs_dma_is_apbh'
> make[1]: *** [vmlinux] Error 1
> make: *** [sub-make] Error 2
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <kernel@pengutronix.de>

Acked-by: Dirk Behme <dirk.behme@de.bosch.com>

Thanks

Dirk

> ---
>  arch/arm/configs/imx_v6_v7_defconfig |    1 +
>  drivers/mtd/nand/Kconfig             |    2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index f725b96..3c9f32f 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -192,6 +192,7 @@ CONFIG_RTC_DRV_MC13XXX=y
>  CONFIG_RTC_DRV_MXC=y
>  CONFIG_DMADEVICES=y
>  CONFIG_IMX_SDMA=y
> +CONFIG_MXS_DMA=y
>  CONFIG_COMMON_CLK_DEBUG=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_EXT2_FS=y
> diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
> index 31bb7e5..8ca4176 100644
> --- a/drivers/mtd/nand/Kconfig
> +++ b/drivers/mtd/nand/Kconfig
> @@ -480,7 +480,7 @@ config MTD_NAND_NANDSIM
>  
>  config MTD_NAND_GPMI_NAND
>          bool "GPMI NAND Flash Controller driver"
> -        depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28 || SOC_IMX6Q)
> +        depends on MTD_NAND && MXS_DMA
>          help
>  	 Enables NAND Flash support for IMX23 or IMX28.
>  	 The GPMI controller is very powerful, with the help of BCH
