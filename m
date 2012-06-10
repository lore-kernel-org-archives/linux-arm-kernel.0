From: michael@walle.cc (Michael Walle)
Date: Sun, 10 Jun 2012 23:21:51 +0200
Subject: [PATCH 1/9] ARM: Kirkwood: Add interrupt controller support for
 DT boards
In-Reply-To: <1339324322-29388-2-git-send-email-andrew@lunn.ch>
References: <1339324322-29388-2-git-send-email-andrew@lunn.ch>
Message-ID: <201206102321.51637.michael@walle.cc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Sonntag 10 Juni 2012, 12:31:53 schrieb Andrew Lunn:
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/arm/mrvl/intc.txt          |   20
> ++++++++++++++++++ arch/arm/boot/dts/kirkwood.dtsi                    |   
> 9 ++++++++ arch/arm/mach-kirkwood/board-dt.c                  |   22
> +++++++++++++++++++- 3 files changed, 50 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> b/Documentation/devicetree/bindings/arm/mrvl/intc.txt index
> 80b9a94..612536e 100644
> --- a/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> +++ b/Documentation/devicetree/bindings/arm/mrvl/intc.txt
> @@ -38,3 +38,23 @@ Example:
>  		reg-names = "mux status", "mux mask";
>  		mrvl,intc-nr-irqs = <2>;
>  	};
> +
> +* Marvell Orion Interrupt controller
> +
> +Required properties
> +- compatible :  Should be "marvell,orion-intc"
> +- #interrupt-cells: Specifies the number of cells needed to encode an
> +  interrupt source. Supported value is <1>
> +- interrupt-controller : So that its clear its an interrupt controller.
> +Optional properties
> +- reg : Not used yet, but will contain the interrupt mask address
> +
> +Example:
> +
> +	intc: interrupt-controller {
> +        	compatible = "marvell,orion-intc", "marvell,intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +                reg = <0xfed20204 0x04>,
> +		      <0xfed20214 0x04>;
> +        };

please fix whitespaces/tabs


> diff --git a/arch/arm/boot/dts/kirkwood.dtsi
> b/arch/arm/boot/dts/kirkwood.dtsi index 926528b..8eab7c4 100644
> --- a/arch/arm/boot/dts/kirkwood.dtsi
> +++ b/arch/arm/boot/dts/kirkwood.dtsi
> @@ -2,6 +2,15 @@
> 
>  / {
>  	compatible = "mrvl,kirkwood";
> +	interrupt-parent = <&intc>;
> +
> +	intc: interrupt-controller {
> +        	compatible = "marvell,orion-intc", "marvell,intc";
> +		interrupt-controller;
> +		#interrupt-cells = <1>;
> +                reg = <0xfed20204 0x04>,
> +		      <0xfed20214 0x04>;
> +        };

ditto

-- 
Michael
