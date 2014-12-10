From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 10 Dec 2014 15:41:15 +0100
Subject: [PATCH 2/4] irqchip: mediatek: Add support for mt8173
In-Reply-To: <1418222233.21309.17.camel@mtksdaap41>
References: <1418208602-35584-1-git-send-email-eddie.huang@mediatek.com>
 <2545975.QDuBFbG7BN@wuerfel> <1418222233.21309.17.camel@mtksdaap41>
Message-ID: <4428865.bnDr16Yqvr@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 10 December 2014 22:37:13 Yingjoe Chen wrote:
> OK, I'll change to something like this in next version:

I've just taken another look at the driver and have a different
suggestion:

> --- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
> +++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
> @@ -17,12 +17,17 @@ Required properties:
>    use the same interrupt-cells format as GIC.
>  - reg: Physical base address of the intpol registers and length of memory
>    mapped region.
> 
> +Optional properties:
> +- mediatek,intpol-number: The number of interrupts supported by intpol,
> +  default 224 if omitted.
> +
>  Example:
>         sysirq: interrupt-controller at 10200100 {
>                 compatible = "mediatek,mt6589-sysirq", "mediatek,mt6577-sysirq";
>                 interrupt-controller;
>                 #interrupt-cells = >;
>                 interrupt-parent = <&gic>;
>                 reg = <0 0x10200100 0 0x1c>;
> +               mediatek,intpol-number = <224>;
>         };

The number of interrupt pins directly corresponds to the size of the reg
property in bits, so I think you can just use that and don't even need
another property.

	Arnd
