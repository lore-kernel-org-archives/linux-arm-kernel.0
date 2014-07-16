From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 17 Jul 2014 01:12:46 +0200
Subject: [PATCH] ARM: at91/dt: fix usb0 clocks definition in sam9n12 dtsi
In-Reply-To: <1405319967-20807-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1405319967-20807-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20140716231245.GA12493@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/07/2014 at 08:39:27 +0200, Boris Brezillon wrote :
> udphs_clk (USB Device Controller clock) is referenced instead of
> uhphs_clk (USB Host Controller clock).
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  arch/arm/boot/dts/at91sam9n12.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/at91sam9n12.dtsi b/arch/arm/boot/dts/at91sam9n12.dtsi
> index 2877959..b84bac5 100644
> --- a/arch/arm/boot/dts/at91sam9n12.dtsi
> +++ b/arch/arm/boot/dts/at91sam9n12.dtsi
> @@ -925,7 +925,7 @@
>  			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
>  			reg = <0x00500000 0x00100000>;
>  			interrupts = <22 IRQ_TYPE_LEVEL_HIGH 2>;
> -			clocks = <&usb>, <&uhphs_clk>, <&udphs_clk>,
> +			clocks = <&usb>, <&uhphs_clk>, <&uhphs_clk>,
>  				 <&uhpck>;
>  			clock-names = "usb_clk", "ohci_clk", "hclk", "uhpck";
>  			status = "disabled";
> -- 
> 1.8.3.2
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
