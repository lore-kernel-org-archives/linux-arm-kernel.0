From: andrew@lunn.ch (Andrew Lunn)
Date: Wed, 20 Jan 2016 18:16:14 +0100
Subject: [PATCH v2 3/7] ARM: dts: kirkwood: gpio-leds fixes for
 linkstation ls-wxl/wsxl
In-Reply-To: <1453304038-28345-4-git-send-email-rogershimizu@gmail.com>
References: <1453211342-25214-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-1-git-send-email-rogershimizu@gmail.com>
 <1453304038-28345-4-git-send-email-rogershimizu@gmail.com>
Message-ID: <20160120171614.GP28750@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2016 at 12:33:54AM +0900, Roger Shimizu wrote:
> Make all leds initially to "off" state except power indicator, so pins below
> change from active_low to active_high:

So what happens when you echo 1 to /sys/class/led/lswxl:red:func/brightness ?

1 should turn the LED on, 0 off. This is what
GPIO_ACTIVE_LOW/GPIO_ACTIVE_HIGH is about, and these are independent
of the initial off/on state.

   Andrew

>   - gpio-leds: "lswxl:red:func" pin
>   - gpio-leds: "lswxl:red:hdderr{0,1}" pin
> 
> Fixes: e54e4b1b622e ("ARM: dts: add buffalo linkstation ls-wxl/wsxl")
> Signed-off-by: Roger Shimizu <rogershimizu@gmail.com>
> ---
>  arch/arm/boot/dts/kirkwood-lswxl.dts | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/arm/boot/dts/kirkwood-lswxl.dts b/arch/arm/boot/dts/kirkwood-lswxl.dts
> index 0e93f6d19259..f4700a60065b 100644
> --- a/arch/arm/boot/dts/kirkwood-lswxl.dts
> +++ b/arch/arm/boot/dts/kirkwood-lswxl.dts
> @@ -206,18 +206,17 @@
>  
>  		led at 5 {
>  			label = "lswxl:red:func";
> -			gpios = <&gpio1 2 GPIO_ACTIVE_LOW>;
> -			default-state = "keep";
> +			gpios = <&gpio1 2 GPIO_ACTIVE_HIGH>;
>  		};
>  
>  		led at 6 {
>  			label = "lswxl:red:hdderr0";
> -			gpios = <&gpio0 8 GPIO_ACTIVE_LOW>;
> +			gpios = <&gpio0 8 GPIO_ACTIVE_HIGH>;
>  		};
>  
>  		led at 7 {
>  			label = "lswxl:red:hdderr1";
> -			gpios = <&gpio1 14 GPIO_ACTIVE_LOW>;
> +			gpios = <&gpio1 14 GPIO_ACTIVE_HIGH>;
>  		};
>  	};
>  
> -- 
> 2.1.4
> 
