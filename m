From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Jun 2018 16:02:56 +0200
Subject: [PATCH 01/29] arm64: dts: renesas: draak: add X12 input dot clock
In-Reply-To: <cover.1529933747.git.horms+renesas@verge.net.au>
References: <cover.1529933747.git.horms+renesas@verge.net.au>
Message-ID: <856e7e42a4aa9a9acfadf84f4ff2b23ba6c69b11.1529933747.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

74.25 Mhz oscillator X12 is connected to DU_DOTCLKIN0.

Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Simon Horman <horms+renesas@verge.net.au>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/r8a77995-draak.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
index 9d73de8bc94d..9d1c33927064 100644
--- a/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
+++ b/arch/arm64/boot/dts/renesas/r8a77995-draak.dts
@@ -82,6 +82,12 @@
 		regulator-boot-on;
 		regulator-always-on;
 	};
+
+	x12_clk: x12 {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <74250000>;
+	};
 };
 
 &extal_clk {
@@ -167,6 +173,11 @@
 	pinctrl-names = "default";
 	status = "okay";
 
+	clocks = <&cpg CPG_MOD 724>,
+		 <&cpg CPG_MOD 723>,
+		 <&x12_clk>;
+	clock-names = "du.0", "du.1", "dclkin.0";
+
 	ports {
 		port at 0 {
 			endpoint {
-- 
2.11.0
