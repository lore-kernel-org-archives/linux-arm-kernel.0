From: shawn.guo@linaro.org (Shawn Guo)
Date: Mon, 10 Feb 2014 14:31:20 +0800
Subject: [PATCH] ARM: dts: i.MX51 babbage: Support diagnostic LED
In-Reply-To: <52F87087.4000908@freescale.com>
References: <1391522263-17877-1-git-send-email-Ying.Liu@freescale.com>
 <20140210030214.GB9628@S2101-09.ap.freescale.net>
 <1392006579.703394606@f357.i.mail.ru>
 <52F87087.4000908@freescale.com>
Message-ID: <20140210063118.GJ9628@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 02:24:07PM +0800, Liu Ying wrote:
> >>> @@ -81,6 +81,17 @@
> >>>  		};
> >>>  	};
> >>>  
> >>> +	leds {
> >>> +		compatible = "gpio-leds";
> >>> +		pinctrl-names = "default";
> >>> +		pinctrl-0 = <&led_pin_gpio2_6>;
> >>> +
> >>> +		led-diagnostic {
> >>> +			label = "diagnostic";
> >>> +			gpios = <&gpio2 6 0>;
> >>
> >> Just out of curiosity, how will you use/trigger the led?
> > 
> > And GPIO bindings should be used to specify active level,
> > GPIO_ACTIVE_HIGH in this case.
> 
> Based on Linux 3.14-rc2, this gives me no single output:
> grep GPIO_ACTIVE arch/arm/boot/dts/ -nr | grep imx

If you grep linux-next, you will find quite a few.

> 
> So, this patch follows the old approach.
> 
> I agree to use GPIO_ACTIVE_HIGH/GPIO_ACTIVE_LOW macros.
> How about generating dedicated patch sets for this purpose?
> Actually, I had one set for i.MX51 platforms.

I prefer to have this change in the same patch.

Shawn
