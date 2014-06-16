From: elder@ieee.org (Alex Elder)
Date: Mon, 16 Jun 2014 14:12:36 -0500
Subject: [PATCH] ARM: bcm_defconfig: re-enable BCM Kona SDHCI driver
In-Reply-To: <1402941376-29594-1-git-send-email-mporter@linaro.org>
References: <1402941376-29594-1-git-send-email-mporter@linaro.org>
Message-ID: <539F41A4.1090606@ieee.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/16/2014 12:56 PM, Matt Porter wrote:
> Since 5d01b7684b7e "mmc: simplify SDHCI Kconfig dependencies",
> MMC_SDHCI_PLTFM is no longer selected by the BCM Kona SDHCI
> driver which is enabled in this defconfig. This results in the
> SDHCI driver not being built and a boot failure. Explictly
> enable MMC_SDHCI_PLTFM in bcm_defconfig so the BCM Kona SDHCI
> driver is built.
> 
> Fixes: 5d01b7684b7e ("mmc: simplify SDHCI Kconfig dependencies")
> Signed-off-by: Matt Porter <mporter@linaro.org>

Works for me.

Tested-by: Alex Elder <elder@linaro.org>

> ---
>  arch/arm/configs/bcm_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/bcm_defconfig b/arch/arm/configs/bcm_defconfig
> index 9d13dae..dcfc559 100644
> --- a/arch/arm/configs/bcm_defconfig
> +++ b/arch/arm/configs/bcm_defconfig
> @@ -98,6 +98,7 @@ CONFIG_MMC_UNSAFE_RESUME=y
>  CONFIG_MMC_BLOCK_MINORS=32
>  CONFIG_MMC_TEST=y
>  CONFIG_MMC_SDHCI=y
> +CONFIG_MMC_SDHCI_PLTFM=y
>  CONFIG_MMC_SDHCI_BCM_KONA=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
> 
