From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu,  5 Mar 2015 10:58:21 +0900
Subject: [PATCH 05/11] ARM: shmobile: sh73a0 dtsi: Add Bus State Controller
 node
In-Reply-To: <cover.1425518682.git.horms+renesas@verge.net.au>
References: <cover.1425518682.git.horms+renesas@verge.net.au>
Message-ID: <217b6e65e55325db2b3f0447c85db08c3a6921cf.1425518682.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Add a node for the Bus State Controller (BSC) on sh73a0, to which
multiple external devices can be connected.

The BSC is driven by the ZB clock, and located in PM domain A4S.
A reference to the latter will be added later.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/sh73a0.dtsi | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sh73a0.dtsi b/arch/arm/boot/dts/sh73a0.dtsi
index ab319b7..70b694f 100644
--- a/arch/arm/boot/dts/sh73a0.dtsi
+++ b/arch/arm/boot/dts/sh73a0.dtsi
@@ -376,6 +376,17 @@
 		status = "disabled";
 	};
 
+	bsc: bus at fec10000 {
+		compatible = "renesas,bsc-sh73a0", "renesas,bsc",
+			     "simple-pm-bus";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges = <0 0 0x20000000>;
+		reg = <0xfec10000 0x400>;
+		interrupts = <0 39 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&zb_clk>;
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.1.4
