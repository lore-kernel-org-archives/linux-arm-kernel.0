From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Tue, 19 Nov 2013 13:59:49 +0100
Subject: [PATCH v2 7/7] ARM: shmobile: armadillo-reference: Use low level IRQ
 for ST1231
In-Reply-To: <1383999839-3339-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383999839-3339-8-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1384865989-12875-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device is configured to generate an active-low interrupt signal that
needs to be acknowledged by the host. Configure the IRQ to trigger on
low level.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Changes since v1:

- Fixed typo (IRQ_TYPE_LOW_LEVEL -> IRQ_TYPE_LEVEL_LOW)

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
1.8.3.2
