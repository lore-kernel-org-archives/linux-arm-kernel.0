From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 11 Aug 2014 14:40:38 +0200
Subject: [RESEND PATCH 1/1] ARM: exynos_defconfig: Enable SBS battery
 support
In-Reply-To: <1407755198-17568-1-git-send-email-javier.martinez@collabora.co.uk>
References: <1407755198-17568-1-git-send-email-javier.martinez@collabora.co.uk>
Message-ID: <1761549.yKSqfXafKr@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

On Monday, August 11, 2014 01:06:38 PM Javier Martinez Canillas wrote:
> Many Exynos5 boards (e.g: Snow, Peach Pit and Pi) have
> a SBS-compliant gas gauge battery. Enable it as module
> so the needed support is available for these boards.
> 
> Suggested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index fc7d168..c390bb9 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -77,6 +77,7 @@ CONFIG_SPI_S3C64XX=y
>  CONFIG_I2C_S3C2410=y
>  CONFIG_DEBUG_GPIO=y
>  CONFIG_POWER_SUPPLY=y
> +CONFIG_BATTERY_SBS=m

Why not make it "=y"?

Rationale:
- currently no hardware related option uses "=m" in exynos_defconfig
- it would match the SBS option usage in multi_v7_defconfig

>  CONFIG_CHARGER_TPS65090=y
>  # CONFIG_HWMON is not set
>  CONFIG_THERMAL=y

Best regards,
--
Bartlomiej Zolnierkiewicz
Samsung R&D Institute Poland
Samsung Electronics
