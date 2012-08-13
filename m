From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 13 Aug 2012 16:33:19 +0200
Subject: [patch] ARM: Kirkwood: Fix iconnect leds
In-Reply-To: <20120805203610.540496769@rtp-net.org>
References: <20120805203610.540496769@rtp-net.org>
Message-ID: <20120813143319.GF12756@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 05, 2012 at 10:35:56PM +0200, Arnaud Patard wrote:
> While converting, a led has been missed leading to wrong power blue led
> definition. Add it back and fix the gpio used on the power blue led.

Acked-by: Andrew Lunn <andrew@lunn.ch>

Jason, please channel this towards t3.6-rc2

       Andrew

> 
> Signed-off-by: Arnaud Patard <arnaud.patard@rtp-net.org>
> Index: alunn/arch/arm/boot/dts/kirkwood-iconnect.dts
> ===================================================================
> --- alunn.orig/arch/arm/boot/dts/kirkwood-iconnect.dts	2012-07-20 09:14:45.000000000 +0200
> +++ alunn/arch/arm/boot/dts/kirkwood-iconnect.dts	2012-07-25 23:46:51.039862074 +0200
> @@ -41,9 +41,13 @@
>  		};
>  		power-blue {
>  			label = "power:blue";
> -			gpios = <&gpio1 11 0>;
> +			gpios = <&gpio1 10 0>;
>  			linux,default-trigger = "timer";
>  		};
> +		power-red {
> +			label = "power:red";
> +			gpios = <&gpio1 11 0>;
> +		};
>  		usb1 {
>  			label = "usb1:blue";
>  			gpios = <&gpio1 12 0>;
> 
> 
