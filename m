From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 May 2014 09:58:19 +0900
Subject: [PATCH 10/11] ARM: shmobile: marzen-reference: Set SMSC lan to use
 irq-push-pull
In-Reply-To: <cover.1400200395.git.horms+renesas@verge.net.au>
References: <cover.1400200395.git.horms+renesas@verge.net.au>
Message-ID: <c9af5428be0cea61a34fa8d5dda83d4c57a03b06.1400200395.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This change makes the DTS consistent with the platform data
that exists in board-marzen.c.

Empirically it does not appear to be necessary.

Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779-marzen-reference.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7779-marzen-reference.dts b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
index 76f5eef..b27c637 100644
--- a/arch/arm/boot/dts/r8a7779-marzen-reference.dts
+++ b/arch/arm/boot/dts/r8a7779-marzen-reference.dts
@@ -45,6 +45,7 @@
 		phy-mode = "mii";
 		interrupt-parent = <&irqpin0>;
 		interrupts = <1 IRQ_TYPE_EDGE_FALLING>;
+		smsc,irq-push-pull;
 		reg-io-width = <4>;
 		vddvario-supply = <&fixedregulator3v3>;
 		vdd33a-supply = <&fixedregulator3v3>;
-- 
1.8.5.2
