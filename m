From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 03 Mar 2017 10:43:14 -0800
Subject: [PATCH 1/1] ARM64: defconfig: enable the leds-pwm driver and
 default-on trigger
In-Reply-To: <20170219222325.7085-2-martin.blumenstingl@googlemail.com>
 (Martin Blumenstingl's message of "Sun, 19 Feb 2017 23:23:25 +0100")
References: <20170219222325.7085-1-martin.blumenstingl@googlemail.com>
 <20170219222325.7085-2-martin.blumenstingl@googlemail.com>
Message-ID: <m2efye2ocd.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Martin Blumenstingl <martin.blumenstingl@googlemail.com> writes:

> This enables the leds-pwm driver to support LEDs which are PWM-powered
> (and thus dimmable). Additionally we have to enable the "default-on"
> trigger - this was not required before because the gpio-leds driver has
> a separate "default-state" property which can be used to enable the LED
> by default.
>
> Signed-off-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>

Applied to v4.12/defconfig of amlogic tree.

Kevin

> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 33b744d54739..b36d02ce6154 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -394,8 +394,10 @@ CONFIG_MMC_SUNXI=y
>  CONFIG_NEW_LEDS=y
>  CONFIG_LEDS_CLASS=y
>  CONFIG_LEDS_GPIO=y
> +CONFIG_LEDS_PWM=y
>  CONFIG_LEDS_SYSCON=y
>  CONFIG_LEDS_TRIGGERS=y
> +CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
>  CONFIG_LEDS_TRIGGER_HEARTBEAT=y
>  CONFIG_LEDS_TRIGGER_CPU=y
>  CONFIG_RTC_CLASS=y
