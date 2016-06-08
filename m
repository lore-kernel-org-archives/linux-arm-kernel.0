From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 8 Jun 2016 12:06:11 +0200
Subject: [PATCH v3 2/2] ARM: at91/dt: sama5d2: Use new compatible for ohci
 node
In-Reply-To: <1465359311-14544-3-git-send-email-wenyou.yang@atmel.com>
References: <1465359311-14544-1-git-send-email-wenyou.yang@atmel.com>
 <1465359311-14544-3-git-send-email-wenyou.yang@atmel.com>
Message-ID: <5757EE13.1080107@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 08/06/2016 06:15, Wenyou Yang a ?crit :
> Use compatible "atmel,sama5d2-ohci" to be capable of suspending
> ports while sleep to save the power consumption.
> 
> Signed-off-by: Wenyou Yang <wenyou.yang@atmel.com>
> ---
> 
> Changes in v3: None
> Changes in v2:
>  - Use the new compatible for ohci-node.
> 
>  arch/arm/boot/dts/sama5d2.dtsi | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/arm/boot/dts/sama5d2.dtsi b/arch/arm/boot/dts/sama5d2.dtsi
> index 78996bd..03d6724 100644
> --- a/arch/arm/boot/dts/sama5d2.dtsi
> +++ b/arch/arm/boot/dts/sama5d2.dtsi
> @@ -232,7 +232,7 @@
>  		};
>  
>  		usb1: ohci at 00400000 {
> -			compatible = "atmel,at91rm9200-ohci", "usb-ohci";
> +			compatible = "atmel,sama5d2-ohci", "usb-ohci";

We must change this to:
+			compatible = "atmel,sama5d2-ohci", "atmel,at91rm9200-ohci", "usb-ohci";

To make it independent from the one that may reach Mainline through the USB git tree.


>  			reg = <0x00400000 0x100000>;
>  			interrupts = <41 IRQ_TYPE_LEVEL_HIGH 2>;
>  			clocks = <&uhphs_clk>, <&uhphs_clk>, <&uhpck>;
> 

Bye,
-- 
Nicolas Ferre
