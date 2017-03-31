From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 31 Mar 2017 18:50:15 +0200
Subject: [PATCH] ARM: dts: armada-38x: label USB and SATA nodes
In-Reply-To: <20170331074115.8111-1-ralph.sennhauser@gmail.com>
References: <20170331074115.8111-1-ralph.sennhauser@gmail.com>
Message-ID: <20170331165015.GJ12814@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> -			sata at a8000 {
> +			satac0: sata at a8000 {

Hi Ralph

Why the c in satac0?

>  
> -			usb3 at f0000 {
> +			usb3_0: usb3 at f0000 {
>  				compatible = "marvell,armada-380-xhci";
>  				reg = <0xf0000 0x4000>,<0xf4000 0x4000>;
>  				interrupts = <GIC_SPI 16 IRQ_TYPE_LEVEL_HIGH>;
> @@ -598,7 +598,7 @@
>  				status = "disabled";
>  			};
>  
> -			usb3 at f8000 {
> +			usb3_1: usb3 at f8000 {
>  				compatible = "marvell,armada-380-xhci";
>  				reg = <0xf8000 0x4000>,<0xfc000 0x4000>;
>  				interrupts = <GIC_SPI 17 IRQ_TYPE_LEVEL_HIGH>;

I can understand what you are saying. But does anybody else care? Are
there other .dtsi files differentiating between USB 1.1, 2 and 3?

      Andrew
