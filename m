From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:23 +0900
Subject: [PATCH 49/69] ARM: shmobile: armadillo-reference: Use low level IRQ
 for ST1231
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <b69e4435e34df68d54e204b37d6bb256606fef5d.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The device is configured to generate an active-low interrupt signal that
needs to be acknowledged by the host. Configure the IRQ to trigger on
low level.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index aef425f..7b80f19 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -95,7 +95,7 @@
 		compatible = "sitronix,st1232";
 		reg = <0x55>;
 		interrupt-parent = <&irqpin1>;
-		interrupts = <2 IRQ_TYPE_NONE>; /* IRQ10: hwirq 2 on irqpin1 */
+		interrupts = <2 IRQ_TYPE_LEVEL_LOW>;
 		pinctrl-0 = <&st1232_pins>;
 		pinctrl-names = "default";
 		gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
-- 
1.8.4
