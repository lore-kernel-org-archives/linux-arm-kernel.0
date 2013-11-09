From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sat,  9 Nov 2013 13:23:56 +0100
Subject: [PATCH 4/7] ARM: shmobile: marzen-reference: Use falling edge IRQ for
 LAN9221
In-Reply-To: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383999839-3339-5-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device is configured to generate an active-low interrupt signal that
is automatically deasserted without requiring any action from the host.
Use falling edge trigger as that is the configuration currently used on
the board.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 0f5c614..13fa8be 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -44,7 +44,7 @@
 
 		phy-mode = "mii";
 		interrupt-parent = <&irqpin0>;
-		interrupts = <1 IRQ_TYPE_NONE>; /* IRQ1: hwirq 1 on irqpin0 */
+		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
 		reg-io-width = <4>;
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
-- 
1.8.1.5
