From: dirk.behme@de.bosch.com (Dirk Behme)
Date: Fri, 3 Aug 2012 10:40:20 +0200
Subject: [PATCH v2 3/3] ARM: imx_v6_v7_defconfig: Select MXS_DMA
In-Reply-To: <1343215100-24005-3-git-send-email-festevam@gmail.com>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
 <1343215100-24005-3-git-send-email-festevam@gmail.com>
Message-ID: <501B8E74.4030803@de.bosch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 25.07.2012 13:18, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Let MXS_DMA be selected by default.
> 
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> ---
> Changes since v1:
> - No changes. Newly introduced in this series
>  arch/arm/configs/imx_v6_v7_defconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
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

Building mainline 3.6-rc1 with imx_v6_v7_defconfig this is still broken 
due to

drivers/built-in.o: In function `gpmi_dma_filter':
clk-fixed-factor.c:(.text+0xab170): undefined reference to `mxs_dma_is_apbh'

Is any fix for this on its way to mainline? Either the above or any 
other one?

Best regards

Dirk
