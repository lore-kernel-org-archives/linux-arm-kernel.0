From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 10 Mar 2015 09:44:49 +0900
Subject: [PATCH 12/15] ARM: shmobile: r8a7794: alt: Fix ethernet controller
 PHY IRQ line
In-Reply-To: <cover.1425947992.git.horms+renesas@verge.net.au>
References: <cover.1425947992.git.horms+renesas@verge.net.au>
Message-ID: <1fc580158714b19fbc3a592a126c58e06728763d.1425947992.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The PHY IRQ line is connected to external IRQ8, not IRQ0. Fix DT
accordingly.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7794-alt.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7794-alt.dts b/arch/arm/boot/dts/r8a7794-alt.dts
index 25bf434..928cfa6 100644
--- a/arch/arm/boot/dts/r8a7794-alt.dts
+++ b/arch/arm/boot/dts/r8a7794-alt.dts
@@ -51,7 +51,7 @@
 	phy1: ethernet-phy at 1 {
 		reg = <1>;
 		interrupt-parent = <&irqc0>;
-		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
+		interrupts = <8 IRQ_TYPE_LEVEL_LOW>;
 		micrel,led-mode = <1>;
 	};
 };
-- 
2.1.4
