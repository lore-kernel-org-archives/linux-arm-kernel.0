From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 18 Jul 2014 15:48:31 +0200
Subject: [PATCH] ARM: at91/dt: fix usb0 clocks definition in sam9n12 dtsi
In-Reply-To: <1405319967-20807-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1405319967-20807-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <53C925AF.9090302@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14/07/2014 08:39, Boris BREZILLON :
> udphs_clk (USB Device Controller clock) is referenced instead of
> uhphs_clk (USB Host Controller clock).
> 
> Signed-off-by: Boris BREZILLON <boris.brezillon@free-electrons.com>

Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>

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
> 


-- 
Nicolas Ferre
