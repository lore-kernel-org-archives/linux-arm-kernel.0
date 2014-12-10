From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 10 Dec 2014 22:37:13 +0800
Subject: [PATCH 2/4] irqchip: mediatek: Add support for mt8173
In-Reply-To: <2545975.QDuBFbG7BN@wuerfel>
References: <1418208602-35584-1-git-send-email-eddie.huang@mediatek.com>
 <1418208602-35584-3-git-send-email-eddie.huang@mediatek.com>
 <2545975.QDuBFbG7BN@wuerfel>
Message-ID: <1418222233.21309.17.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi Arnd,

On Wed, 2014-12-10 at 12:00 +0100, Arnd Bergmann wrote:
> On Wednesday 10 December 2014 18:50:00 Eddie Huang wrote:
> > From: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > 
> > MT8173 intpol have 32 more irq pins, add support to it.
> > 
> > Signed-off-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > Signed-off-by: Eddie Huang <eddie.huang@mediatek.com>
> > 
> 
> How about adding a property for the number of irq pins and leave the
> old compatible string in place? I don't think it would be good if
> we have to update this driver for each new SoC that uses this
> irqchip just to change one number.
> 
> 	Arnd

OK, I'll change to something like this in next version:


--- a/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
+++ b/Documentation/devicetree/bindings/arm/mediatek/mediatek,sysirq.txt
@@ -17,12 +17,17 @@ Required properties:
   use the same interrupt-cells format as GIC.
 - reg: Physical base address of the intpol registers and length of memory
   mapped region.

+Optional properties:
+- mediatek,intpol-number: The number of interrupts supported by intpol,
+  default 224 if omitted.
+
 Example:
        sysirq: interrupt-controller at 10200100 {
                compatible = "mediatek,mt6589-sysirq", "mediatek,mt6577-sysirq";
                interrupt-controller;
                #interrupt-cells = <3>;
                interrupt-parent = <&gic>;
                reg = <0 0x10200100 0 0x1c>;
+               mediatek,intpol-number = <224>;
        };

Joe.C
