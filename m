From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  4 Nov 2014 10:50:25 +0900
Subject: [PATCH 02/10] ARM: shmobile: r8a7779: Add DU node to device tree
In-Reply-To: <cover.1415058552.git.horms+renesas@verge.net.au>
References: <cover.1415058552.git.horms+renesas@verge.net.au>
Message-ID: <1f08bbe8ac737a728812df88cbb3049842df7b84.1415058552.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

Add the DU device with a disabled state. Boards that want to enable the
DU need to specify the output topology

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
[horms+renesas at verge.net.au: resolved minor conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7779.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/r8a7779.dtsi b/arch/arm/boot/dts/r8a7779.dtsi
index 7cfba9a..fda814e 100644
--- a/arch/arm/boot/dts/r8a7779.dtsi
+++ b/arch/arm/boot/dts/r8a7779.dtsi
@@ -379,6 +379,30 @@
 		status = "disabled";
 	};
 
+	du: display at fff80000 {
+		compatible = "renesas,du-r8a7779";
+		reg = <0 0xfff80000 0 0x40000>;
+		interrupts = <0 31 IRQ_TYPE_LEVEL_HIGH>;
+		clocks = <&mstp1_clks R8A7779_CLK_DU>;
+		status = "disabled";
+
+		ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
+				reg = <0>;
+				du_out_rgb0: endpoint {
+				};
+			};
+			port at 1 {
+				reg = <1>;
+				du_out_rgb1: endpoint {
+				};
+			};
+		};
+	};
+
 	clocks {
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.1.1
