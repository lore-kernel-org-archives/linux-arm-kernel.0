From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:11 +0900
Subject: [PATCH 37/69] ARM: shmobile: marzen-reference: Use falling edge IRQ
 for LAN9221
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <e60038eda492460c46833f4a54bebd256018a912.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The device is configured to generate an active-low interrupt signal that
is automatically deasserted without requiring any action from the host.
Use falling edge trigger as that is the configuration currently used on
the board.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
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
1.8.4
