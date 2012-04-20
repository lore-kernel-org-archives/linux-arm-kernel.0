From: akpm@linux-foundation.org (Andrew Morton)
Date: Fri, 20 Apr 2012 14:34:27 -0700
Subject: [PATCH 10/12] leds-atmel-pwm.c: Make pwmled_probe() __devinit
In-Reply-To: <23f8dba8a3e1ae21a5953747b63dc0a21fcba868.1334567594.git.nicolas.ferre@atmel.com>
References: <cover.1334567594.git.nicolas.ferre@atmel.com>
 <23f8dba8a3e1ae21a5953747b63dc0a21fcba868.1334567594.git.nicolas.ferre@atmel.com>
Message-ID: <20120420143427.97c08ee5.akpm@linux-foundation.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 16 Apr 2012 11:20:54 +0200
Nicolas Ferre <nicolas.ferre@atmel.com> wrote:

> Commit 892a884 (leds: convert led platform drivers to module_platform_driver)
> is omitting the section mismatch error: so change annotation of the probe
> function to __devinit instead of __init.
> 
> ...
>
> --- a/drivers/leds/leds-atmel-pwm.c
> +++ b/drivers/leds/leds-atmel-pwm.c
> @@ -35,7 +35,7 @@ static void pwmled_brightness(struct led_classdev *cdev, enum led_brightness b)
>   * NOTE:  we reuse the platform_data structure of GPIO leds,
>   * but repurpose its "gpio" number as a PWM channel number.
>   */
> -static int __init pwmled_probe(struct platform_device *pdev)
> +static int __devinit pwmled_probe(struct platform_device *pdev)
>  {
>  	const struct gpio_led_platform_data	*pdata;
>  	struct pwmled				*leds;

This is theoretically oopsable and the patch is probably needed in 3.4
and 3.3.x.

But you've applied it to linu-next via your own tree so I won't be
merging it.
