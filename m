From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 13 Dec 2013 11:31:12 +0900
Subject: [PATCH 38/69] ARM: shmobile: bockw-reference: Use falling edge IRQ
 for LAN9221
In-Reply-To: <cover.1386901186.git.horms+renesas@verge.net.au>
References: <cover.1386901186.git.horms+renesas@verge.net.au>
Message-ID: <08281424f1ca5680e4a17656f3d9b978103779eb.1386901186.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The device is configured to generate an active-low interrupt signal that
is automatically deasserted without requiring any action from the host.
Configure the IRQ to trigger on falling edge.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index 2000cf8..bb62c7a 100644
--- a/arch/arm/boot/dts/r8a7778-bockw-reference.dts
+++ b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
@@ -46,7 +46,7 @@
 
 		phy-mode = "mii";
 		interrupt-parent = <&irqpin>;
-		interrupts = <0 IRQ_TYPE_NONE>; /* IRQ0: hwirq 0 on irqpin */
+		interrupts = <0 IRQ_TYPE_EDGE_FALLING>;
 		reg-io-width = <4>;
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
-- 
1.8.4
