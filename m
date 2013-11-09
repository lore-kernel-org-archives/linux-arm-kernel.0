From: laurent.pinchart+renesas@ideasonboard.com (Laurent Pinchart)
Date: Sat,  9 Nov 2013 13:23:57 +0100
Subject: [PATCH 5/7] ARM: shmobile: bockw-reference: Use falling edge IRQ for
 LAN9221
In-Reply-To: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
References: <1383999839-3339-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
Message-ID: <1383999839-3339-6-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The device is configured to generate an active-low interrupt signal that
is automatically deasserted without requiring any action from the host.
Configure the IRQ to trigger on falling edge.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
 arch/arm/boot/dts/r8a7778-bockw-reference.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7778-bockw-reference.dts b/arch/arm/boot/dts/r8a7778-bockw-reference.dts
index f887dc1..4e2bcee 100644
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
1.8.1.5
