From: shc_work@mail.ru (=?UTF-8?B?QWxleGFuZGVyIFNoaXlhbg==?=)
Date: Mon, 15 Jul 2013 19:30:00 +0400
Subject: =?UTF-8?B?UmU6IFtQQVRDSCAxMy8yMl0gbGNkOiBBZGQgR1BJTyBMQ0QgZHJpdmVyLg==?=
In-Reply-To: <1373900227-341-14-git-send-email-denis@eukrea.com>
References: <1373900227-341-1-git-send-email-denis@eukrea.com>
 <1373900227-341-14-git-send-email-denis@eukrea.com>
Message-ID: <1373902200.734772008@f148.mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> Signed-off-by: Denis Carikli <denis@eukrea.com>
> ---
>  .../bindings/video/backlight/gpio-lcd.txt          |   15 ++
>  drivers/video/backlight/Kconfig                    |    8 +
>  drivers/video/backlight/Makefile                   |    1 +
>  drivers/video/backlight/gpio_lcd.c                 |  178 ++++++++++++++++++++
>  4 files changed, 202 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/video/backlight/gpio-lcd.txt
>  create mode 100644 drivers/video/backlight/gpio_lcd.c
> 
> diff --git a/Documentation/devicetree/bindings/video/backlight/gpio-lcd.txt b/Documentation/devicetree/bindings/video/backlight/gpio-lcd.txt
> new file mode 100644
> index 0000000..4ff409d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/video/backlight/gpio-lcd.txt
> @@ -0,0 +1,15 @@
> +gpio-lcd bindings
> +
> +Required properties:
> +  - compatible: "gpio-lcd"
> +  - gpios: describes the gpio that is used for enabling/disabling the lcd
> +     (see GPIO binding[0] for more details).
> +
> +[0]: Documentation/devicetree/bindings/gpio/gpio.txt
> +
> +Example:
> +
> +	lcd {
> +		compatible = "gpio-lcd";
> +		gpios = <&gpio3 13 0>;
> +	};
> diff --git a/drivers/video/backlight/Kconfig b/drivers/video/backlight/Kconfig
> index 70e7706..eaf0525 100644
> --- a/drivers/video/backlight/Kconfig
> +++ b/drivers/video/backlight/Kconfig
> @@ -34,6 +34,14 @@ config LCD_CORGI
>  	  Say y here to support the LCD panels usually found on SHARP
>  	  corgi (C7x0) and spitz (Cxx00) models.
>  
> +config LCD_GPIO
> +	tristate "LCD GPIO Driver"
> +	depends on OF && GPIOLIB
> +	help
> +	  If your LCD enbling/disabling is controlled by a GPIO
> +	  and that you use the device tree for booting,
> +	  say y to enable the LCD GPIO driver.
> +

Instead of using GPIO maybe it would be better to use a regulator here?
That would be a universal solution.
Thanks.

---
