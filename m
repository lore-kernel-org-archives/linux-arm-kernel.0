From: shawn.guo@linaro.org (Shawn Guo)
Date: Sun, 30 Nov 2014 22:54:51 +0800
Subject: [PATCH] ARM: defconfig: imx_v6_v7_defconfig updates
In-Reply-To: <1416614103-21237-1-git-send-email-shawn.guo@linaro.org>
References: <1416614103-21237-1-git-send-email-shawn.guo@linaro.org>
Message-ID: <20141130145447.GA2411@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd, Olof,

On Sat, Nov 22, 2014 at 07:55:03AM +0800, Shawn Guo wrote:
> From: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
> 
> This is a squash of several imx_v6_v7_defconfig update patches.
> 
>  - Enable tlv320aic3x audio codec by default (Phytec PBAB01 board)
>  - Enable DS1307 rtc and gpio fan by default (TBS2910 board)
>  - Select thermal related drivers
>  - Add SNVS power off driver
> 
> Signed-off-by: Dmitry Lavnikevich <d.lavnikevich@sam-solutions.com>
> Signed-off-by: Soeren Moch <smoch@web.de>
> Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
> Signed-off-by: Robin Gong <b38343@freescale.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>

I haven't found this patch on arm-soc next/defconfig branch.  Can you
please apply it?  Thanks.

Shawn

> ---
>  arch/arm/configs/imx_v6_v7_defconfig | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
> index 8fca6e276b69..c7b8fba8654b 100644
> --- a/arch/arm/configs/imx_v6_v7_defconfig
> +++ b/arch/arm/configs/imx_v6_v7_defconfig
> @@ -162,7 +162,13 @@ CONFIG_SPI_IMX=y
>  CONFIG_GPIO_SYSFS=y
>  CONFIG_GPIO_MC9S08DZ60=y
>  CONFIG_GPIO_STMPE=y
> -# CONFIG_HWMON is not set
> +CONFIG_SENSORS_GPIO_FAN=y
> +CONFIG_THERMAL=y
> +CONFIG_CPU_THERMAL=y
> +CONFIG_IMX_THERMAL=y
> +CONFIG_POWER_SUPPLY=y
> +CONFIG_POWER_RESET=y
> +CONFIG_POWER_RESET_IMX=y
>  CONFIG_WATCHDOG=y
>  CONFIG_IMX2_WDT=y
>  CONFIG_MFD_DA9052_I2C=y
> @@ -210,6 +216,7 @@ CONFIG_SND_SOC_IMX_WM8962=y
>  CONFIG_SND_SOC_IMX_SGTL5000=y
>  CONFIG_SND_SOC_IMX_SPDIF=y
>  CONFIG_SND_SOC_IMX_MC13783=y
> +CONFIG_SND_SOC_TLV320AIC3X=y
>  CONFIG_SND_SIMPLE_CARD=y
>  CONFIG_USB=y
>  CONFIG_USB_EHCI_HCD=y
> @@ -238,6 +245,7 @@ CONFIG_LEDS_TRIGGER_BACKLIGHT=y
>  CONFIG_LEDS_TRIGGER_GPIO=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_INTF_DEV_UIE_EMUL=y
> +CONFIG_RTC_DRV_DS1307=y
>  CONFIG_RTC_DRV_ISL1208=y
>  CONFIG_RTC_DRV_PCF8563=y
>  CONFIG_RTC_DRV_MC13XXX=y
> -- 
> 1.9.1
> 
