From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Fri, 9 May 2014 10:07:19 +0300
Subject: [PATCH 4/4] ARM: dts: Add LCD panel sharp ls037v7dw01 support
 for omap3-evm and ldp
In-Reply-To: <20140508233628.GJ2198@atomide.com>
References: <1398815562-24113-1-git-send-email-tony@atomide.com>
 <1398815562-24113-5-git-send-email-tony@atomide.com>
 <CAGhQ9Vwa8xXQEo5dNEKAvmaS9DoBjVSthtd8=owk+atVdFuiiA@mail.gmail.com>
 <20140430174751.GA12362@atomide.com> <20140505183919.GA15463@atomide.com>
 <20140508233628.GJ2198@atomide.com>
Message-ID: <536C7EA7.5000306@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/14 02:36, Tony Lindgren wrote:

> --- /dev/null
> +++ b/arch/arm/boot/dts/omap-panel-sharp-ls037v7dw01.dtsi
> @@ -0,0 +1,82 @@
> +/*
> + * Common file for omap dpi panels with QVGA and reset pins
> + *
> + * Note that the board specifc DTS file needs to specify
> + * at minimum the GPIO enable-gpios for display, and
> + * gpios for gpio-backlight.
> + */

This looks very board specific to me... The regulator and the use of
mcspi1 depend on the board, so this file can't be used on just any omap
board with the same panel. And this can (probably) only be used on
boards with a single display. Do those boards have tv-out?

So I have nothing against having common files, but shouldn't this be
named something more specific? If the boards involved are TI's OMAP3
development boards, maybe this should be something like...
omap3-ti-dev-panel-sharp-ls037v7dw01.dtsi. Well, that's a quite long one.

> +/ {
> +	aliases {
> +		display0 = &lcd0;
> +	};
> +
> +	backlight0: backlight {
> +		compatible = "gpio-backlight";
> +	};
> +
> +	/* 3.3V GPIO controlled regulator for LCD_ENVDD */
> +	lcd_3v3: regulator-lcd-3v3 {
> +		compatible = "regulator-fixed";
> +		regulator-name = "lcd_3v3";
> +		regulator-min-microvolt = <3300000>;
> +		regulator-max-microvolt = <3300000>;
> +		startup-delay-us = <70000>;
> +		regulator-always-on;

Why always-on?

 Tomi


-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140509/5a61a5c8/attachment.sig>
