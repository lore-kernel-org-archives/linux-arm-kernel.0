From: HartleyS@visionengravers.com (Hartley Sweeten)
Date: Tue, 16 Jun 2015 18:04:17 +0000
Subject: [PATCH] ARM: ep93xx: add LEDs and triggers to defconfig
In-Reply-To: <1434443764-25973-1-git-send-email-linus.walleij@linaro.org>
References: <1434443764-25973-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <DC148C5AA1CEBA4E87973D432B1C2D883D4A378D@P3PWEX4MB008.ex4.secureserver.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, June 16, 2015 1:36 AM, Linus Walleij wrote:
> The EP93xx has two designated LEDs (not always connected): a
> green and a red one. These are registered in the core, so let's
> enable the driver and some triggers.
>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
>  arch/arm/configs/ep93xx_defconfig | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/arch/arm/configs/ep93xx_defconfig b/arch/arm/configs/ep93xx_defconfig
> index b3c32d0d4573..9a5205abc7c3 100644
> --- a/arch/arm/configs/ep93xx_defconfig
> +++ b/arch/arm/configs/ep93xx_defconfig
> @@ -99,6 +99,11 @@ CONFIG_USB_SERIAL_CONSOLE=y
>  CONFIG_USB_SERIAL_PL2303=y
>  CONFIG_MMC=y
>  CONFIG_MMC_SPI=y
> +CONFIG_NEW_LEDS=y
> +CONFIG_LEDS_CLASS=y
> +CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>  CONFIG_RTC_CLASS=y
>  CONFIG_RTC_DRV_DS1307=y
>  CONFIG_RTC_DRV_M48T86=y

Makes sense to me.
Reviewed-by: H Hartley Sweeten <hsweeten@visionengravers.com>

Linus,

Since you are updating the ep93xx_defconfig...

To use the I2C on ep93xx we need CONFIG_I2C_GPIO. Also,
do we really need the CONFIG_I2C_DEBUG_* options enabled?

In order for DMA to work with the SPI driver we also need:
CONFIG_DMADEVICES and CONFIG_EP93XX_DMA enabled.

Regards,
Hartley
