From: hartleys@visionengravers.com (H Hartley Sweeten)
Date: Tue, 10 May 2011 18:02:20 -0500
Subject: [PATCH] [wip] ARM: imx: register "leds-gpio" device using new
	helper function
In-Reply-To: <1305017456-10910-2-git-send-email-u.kleine-koenig@pengutronix.de>
References: <20110510073152.GF29089@pengutronix.de>
	<1305017456-10910-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<1305017456-10910-2-git-send-email-u.kleine-koenig@pengutronix.de>
Message-ID: <0D753D10438DA54287A00B027084269764D2C3CD1E@AUSP01VMBX24.collaborationhost.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, May 10, 2011 1:51 AM, Uwe Kleine-K?nig wrote:
>
> This converts eukrea_mbimx27-baseboard to the new helper function.
>
> bloat-o-meter reports for this change:
>
>	add/remove: 1/1 grow/shrink: 0/1 up/down: 128/-220 (-92)
>	function                                     old     new   delta
>	gpio_led_register_device                       -     128    +128
>	platform_devices                              28      24      -4
>	leds_gpio                                    216       -    -216
>
> Additionally gpio_led_info (12 bytes) and gpio_leds (32 Bytes) are
> initdata now as is gpio_led_register_device.

FWIW, similar results with ep93xx:

add/remove: 1/1 grow/shrink: 2/0 up/down: 137/-240 (-103)
function                                     old     new   delta
gpio_led_register_device                       -     128    +128
kernel_config_data                         10474   10479      +5
ep93xx_init_devices                          116     120      +4
ep93xx_leds                                  240       -    -240

Regards,
Hartley
