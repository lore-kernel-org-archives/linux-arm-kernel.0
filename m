From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sat,  9 Nov 2013 13:23:59 +0100
Subject: [PATCH 7/7] ARM: shmobile: armadillo-reference: Use low level IRQ for
 ST1231
In-Reply-To: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383999839-3339-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device is configured to generate an active-low interrupt signal that
needs to be acknowledged by the host. Configure the IRQ to trigger on
low level.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index aef425f..04e9d49 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -95,7 +95,7 @@
 		compatible = "sitronix,st1232";
 		reg = <0x55>;
 		interrupt-parent = <&irqpin1>;
-		interrupts = <2 IRQ_TYPE_NONE>; /* IRQ10: hwirq 2 on irqpin1 */
+		interrupts = <2 IRQ_TYPE_LOW_LEVEL>;
 		pinctrl-0 = <&st1232_pins>;
 		pinctrl-names = "default";
 		gpios = <&pfc 166 GPIO_ACTIVE_LOW>;
-- 
1.8.1.5
