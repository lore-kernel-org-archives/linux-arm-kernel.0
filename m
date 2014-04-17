From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Apr 2014 09:32:12 +0900
Subject: [PATCH 4/5] ARM: shmobile: r8a7740: drop address cells from GIC node
In-Reply-To: <cover.1397694064.git.horms+renesas@verge.net.au>
References: <cover.1397694064.git.horms+renesas@verge.net.au>
Message-ID: <64c04a79c377e23449c59060727fcd34cc798eb6.1397694064.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Lucas Stach <l.stach@pengutronix.de>

This is likely a copy-and-paste error from the
ARM GIC documentation, that has already been fixed.

address-cells should have been set to 0, as with the size
cells. As having those properties set to 0 is the
same thing as not specifying them, drop them completely.

Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
Acked-by: Rob Herring <robh@kernel.org>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740.dtsi | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/boot/dts/r8a7740.dtsi b/arch/arm/boot/dts/r8a7740.dtsi
index 8280884..2551e94 100644
--- a/arch/arm/boot/dts/r8a7740.dtsi
+++ b/arch/arm/boot/dts/r8a7740.dtsi
@@ -28,7 +28,6 @@
 	gic: interrupt-controller at c2800000 {
 		compatible = "arm,cortex-a9-gic";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
 		interrupt-controller;
 		reg = <0xc2800000 0x1000>,
 		      <0xc2000000 0x1000>;
-- 
1.8.4
