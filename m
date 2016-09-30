From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 30 Sep 2016 19:51:28 +0530
Subject: [PATCH 3/6] ARM: dts: da850-lcdk: enable the LCD controller
In-Reply-To: <1475166715-7857-4-git-send-email-bgolaszewski@baylibre.com>
References: <1475166715-7857-1-git-send-email-bgolaszewski@baylibre.com>
 <1475166715-7857-4-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <29c3b30d-ce3f-078d-03a4-a98b0ae0cddc@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 29 September 2016 10:01 PM, Bartosz Golaszewski wrote:
> From: Karl Beldan <kbeldan@baylibre.com>
> 
> This adds the pins used by the LCD controller, and uses 'tilcdc,panel'
> with some default timings for 800x600.
> 
> Tested on an LCDK connected on the VGA port (the LCDC is connected to
> this port via a THS8135).
> 
> Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
> [Bartosz:
>   - fixed whitespace errors
>   - tweaked the description
>   - fixed the incorrect hback-porch value
>   - other minor tweaks]
> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> ---

> +	lcd_pins: pinmux_lcd_pins {
> +		pinctrl-single,bits = <
> +			/*
> +			 * LCD_D[2], LCD_D[3], LCD_D[4], LCD_D[5],
> +			 * LCD_D[6], LCD_D[7]
> +			 */
> +			0x40 0x22222200 0xffffff00
> +			/*
> +			 * LCD_D[10], LCD_D[11], LCD_D[12], LCD_D[13],
> +			 * LCD_D[14], LCD_D[15], LCD_D[0], LCD_D[1]
> +			 */
> +			0x44 0x22222222 0xffffffff
> +			/* LCD_D[8], LCD_D[9] */
> +			0x48 0x00000022 0x000000ff
> +
> +			/* LCD_PCLK */
> +			0x48 0x02000000 0x0f000000
> +			/* LCD_AC_ENB_CS, LCD_VSYNC, LCD_HSYNC */
> +			0x4c 0x02000022 0x0f0000ff
> +		>;
> +	};

Since almost all boards that use LCD will configure the pins in the same
way, we can move this to da850.dtsi. Please see existing examples of the
same.

The only place where we don't do this is if the common pinmux definition
may not find much reuse because of differing nature of how the external
peripherals are interfaced.

Thanks,
Sekhar
