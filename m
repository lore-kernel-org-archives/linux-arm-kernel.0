From: shijie8@gmail.com (Huang Shijie)
Date: Wed, 25 Jul 2012 11:05:58 -0400
Subject: [PATCH v2 3/3] ARM: imx_v6_v7_defconfig: Select MXS_DMA
In-Reply-To: <1343215100-24005-3-git-send-email-festevam@gmail.com>
References: <1343215100-24005-1-git-send-email-festevam@gmail.com>
 <1343215100-24005-3-git-send-email-festevam@gmail.com>
Message-ID: <CAMiH66EA4O0s8hfXkr_SJ56+q7eZ8w0=3C1r_C+m2Os1RxprmA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio:

On Wed, Jul 25, 2012 at 7:18 AM, Fabio Estevam <festevam@gmail.com> wrote:
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
Is this patch needed? The mxs-dma only has one user, the gpmi-nand in mx6q.
this patch makes the kernel built-in the mxs-dma, even the gpmi-nand
is not enabled.

Huang Shijie

>  CONFIG_COMMON_CLK_DEBUG=y
>  # CONFIG_IOMMU_SUPPORT is not set
>  CONFIG_EXT2_FS=y
> --
> 1.7.1
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
