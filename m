From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Wed, 29 Aug 2012 14:49:36 +0530
Subject: [PATCH] ARM: tegra_defconfig: enable APB DMA support
In-Reply-To: <1346230800-3167-1-git-send-email-u.kleine-koenig@pengutronix.de>
References: <1346230800-3167-1-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <503DDEA8.1000405@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 29 August 2012 02:30 PM, Uwe Kleine-K?nig wrote:
> Additionally DMADEVICES needs to be enabled as TEGRA20_APB_DMA depends
> on that.
>
> Signed-off-by: Uwe Kleine-K?nig<u.kleine-koenig@pengutronix.de>
> ---
>   arch/arm/configs/tegra_defconfig |    2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
> index db22453..0d6bb73 100644
> --- a/arch/arm/configs/tegra_defconfig
> +++ b/arch/arm/configs/tegra_defconfig
> @@ -145,6 +145,8 @@ CONFIG_MMC_SDHCI_TEGRA=y
>   CONFIG_RTC_CLASS=y
>   CONFIG_RTC_DRV_EM3027=y
>   CONFIG_RTC_DRV_TEGRA=y
> +CONFIG_DMADEVICES=y
> +CONFIG_TEGRA20_APB_DMA=y
>   CONFIG_STAGING=y
>   CONFIG_SENSORS_ISL29018=y
>   CONFIG_SENSORS_ISL29028=y

Hi Uwe,
Tegra team is working on to enable the new dma drivr which is dmaengine 
based. We have dma legacy driver as of now in mach-tegra. Some of the 
tests are failing with new dmadriver and so we are not able to enable it.
The patch series which is posted against this is:

[PATCH 0/5] ARM: tegra: move all APB DMA client to dmaengine based driver

Thanks,
Laxman
