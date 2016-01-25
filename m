From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 25 Jan 2016 14:01:14 +0100
Subject: [PATCH v2] ARM: dts: orion5x: gpio pin fixes for linkstation
 lswtgl
In-Reply-To: <1453388436-8390-1-git-send-email-rogershimizu@gmail.com>
References: <1453286688-9533-1-git-send-email-rogershimizu@gmail.com>
 <1453388436-8390-1-git-send-email-rogershimizu@gmail.com>
Message-ID: <20160125130114.GX3880@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 22, 2016 at 12:00:36AM +0900, Roger Shimizu wrote:
> Here're a few gpio pin related fixes:
>   - remove pinctrl-0 definition from pinctrl, since those pins are used
>     in other places such as gpio-fan and regulators.
>   - keep initial state of power led
>   - fix for alarm pin of gpio-fan.
> 
> Fixes: dc57844a736f ("ARM: dts: orion5x: add buffalo linkstation ls-wtgl")
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

	     Andrew

> ---
>  arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
> index 3daec912b4bf..420788229e6f 100644
> --- a/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
> +++ b/arch/arm/boot/dts/orion5x-linkstation-lswtgl.dts
> @@ -1,7 +1,8 @@
>  /*
>   * Device Tree file for Buffalo Linkstation LS-WTGL
>   *
> - * Copyright (C) 2015, Roger Shimizu <rogershimizu@gmail.com>
> + * Copyright (C) 2015, 2016
> + * Roger Shimizu <rogershimizu@gmail.com>
>   *
>   * This file is dual-licensed: you can use it either under the terms
>   * of the GPL or the X11 license, at your option. Note that this dual
> @@ -69,8 +70,6 @@
>  
>  		internal-regs {
>  			pinctrl: pinctrl at 10000 {
> -				pinctrl-0 = <&pmx_usb_power &pmx_power_hdd
> -					&pmx_fan_low &pmx_fan_high &pmx_fan_lock>;
>  				pinctrl-names = "default";
>  
>  				pmx_led_power: pmx-leds {
> @@ -162,6 +161,7 @@
>  		led at 1 {
>  			label = "lswtgl:blue:power";
>  			gpios = <&gpio0 0 GPIO_ACTIVE_LOW>;
> +			default-state = "keep";
>  		};
>  
>  		led at 2 {
> @@ -188,7 +188,7 @@
>  				3250 1
>  				5000 0>;
>  
> -		alarm-gpios = <&gpio0 2 GPIO_ACTIVE_HIGH>;
> +		alarm-gpios = <&gpio0 6 GPIO_ACTIVE_HIGH>;
>  	};
>  
>  	restart_poweroff {
> -- 
> 2.1.4
> 
