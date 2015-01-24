From: kgene@kernel.org (Kukjin Kim)
Date: Sat, 24 Jan 2015 13:53:51 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable PMIC and MUIC drivers for
 Gears and Trats2
In-Reply-To: <1422022966-15897-1-git-send-email-k.kozlowski@samsung.com>
References: <1422022966-15897-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <54C3255F.6000504@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/23/15 23:22, Krzysztof Kozlowski wrote:
> Enable drivers for PMICs and MUICs present on Exynos-based devices:
>  - max14577: charger, extcon, fuel gauge (max17040), regulator,
>    used on: Gear 1, Gear 2,
>  - max77693: charger, extcon, fuel gauge (max17042),
>    used on: Trats2,
> 
> This allows full usage of charging stack on these devices along with
> extcon connector.
> 
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  arch/arm/configs/exynos_defconfig | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
> index 3d0c5d65c741..01758378a1b1 100644
> --- a/arch/arm/configs/exynos_defconfig
> +++ b/arch/arm/configs/exynos_defconfig
> @@ -83,6 +83,10 @@ CONFIG_I2C_S3C2410=y
>  CONFIG_DEBUG_GPIO=y
>  CONFIG_POWER_SUPPLY=y
>  CONFIG_BATTERY_SBS=y
> +CONFIG_BATTERY_MAX17040=y
> +CONFIG_BATTERY_MAX17042=y
> +CONFIG_CHARGER_MAX14577=y
> +CONFIG_CHARGER_MAX77693=y
>  CONFIG_CHARGER_TPS65090=y
>  CONFIG_HWMON=y
>  CONFIG_SENSORS_LM90=y
> @@ -94,6 +98,7 @@ CONFIG_S3C2410_WATCHDOG=y
>  CONFIG_MFD_CROS_EC=y
>  CONFIG_MFD_CROS_EC_I2C=y
>  CONFIG_MFD_CROS_EC_SPI=y
> +CONFIG_MFD_MAX14577=y
>  CONFIG_MFD_MAX77686=y
>  CONFIG_MFD_MAX77693=y
>  CONFIG_MFD_MAX8997=y
> @@ -102,6 +107,7 @@ CONFIG_MFD_TPS65090=y
>  CONFIG_REGULATOR=y
>  CONFIG_REGULATOR_FIXED_VOLTAGE=y
>  CONFIG_REGULATOR_GPIO=y
> +CONFIG_REGULATOR_MAX14577=y
>  CONFIG_REGULATOR_MAX8997=y
>  CONFIG_REGULATOR_MAX77686=y
>  CONFIG_REGULATOR_MAX77802=y
> @@ -168,6 +174,9 @@ CONFIG_COMMON_CLK_MAX77686=y
>  CONFIG_COMMON_CLK_MAX77802=y
>  CONFIG_COMMON_CLK_S2MPS11=y
>  CONFIG_EXYNOS_IOMMU=y
> +CONFIG_EXTCON=y
> +CONFIG_EXTCON_MAX14577=y
> +CONFIG_EXTCON_MAX77693=y
>  CONFIG_IIO=y
>  CONFIG_EXYNOS_ADC=y
>  CONFIG_PWM=y

I've applied, thanks.

- Kukjin
