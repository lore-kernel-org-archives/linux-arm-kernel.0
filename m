From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Sep 2018 11:08:59 +0200
Subject: [PATCH 04/58] arm64: dts: renesas: Convert to new LVDS DT bindings
In-Reply-To: <cover.1536828567.git.horms+renesas@verge.net.au>
References: <cover.1536828567.git.horms+renesas@verge.net.au>
Message-ID: <58e8ed2ee9abe7181d68d5cf067a858a753c77a0.1536828567.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The internal LVDS encoder now has DT bindings separate from the DU. Port
the r8a7795 and r8a7796 device trees over to the new model.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 .../boot/dts/renesas/r8a7795-es1-salvator-x.dts    |  3 +-
 arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts     |  3 +-
 arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts |  3 +-
 .../arm64/boot/dts/renesas/r8a7795-salvator-xs.dts |  3 +-
 arch/arm64/boot/dts/renesas/r8a7795.dtsi           | 36 ++++++++++++++++++----
 arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts     |  3 +-
 arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts |  3 +-
 arch/arm64/boot/dts/renesas/r8a7796.dtsi           | 36 ++++++++++++++++++----
 8 files changed, 66 insertions(+), 24 deletions(-)

diff --git a/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
index 6b5fa91f1d5d..0895503b69d0 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-es1-salvator-x.dts
@@ -40,12 +40,11 @@
 		 <&cpg CPG_MOD 723>,
 		 <&cpg CPG_MOD 722>,
 		 <&cpg CPG_MOD 721>,
-		 <&cpg CPG_MOD 727>,
 		 <&versaclock5 1>,
 		 <&x21_clk>,
 		 <&x22_clk>,
 		 <&versaclock5 2>;
-	clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0",
+	clock-names = "du.0", "du.1", "du.2", "du.3",
 		      "dclkin.0", "dclkin.1", "dclkin.2", "dclkin.3";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
index df50bf46406e..54515eaf0310 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-h3ulcb.dts
@@ -41,11 +41,10 @@
 		 <&cpg CPG_MOD 723>,
 		 <&cpg CPG_MOD 722>,
 		 <&cpg CPG_MOD 721>,
-		 <&cpg CPG_MOD 727>,
 		 <&versaclock5 1>,
 		 <&versaclock5 3>,
 		 <&versaclock5 4>,
 		 <&versaclock5 2>;
-	clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0",
+	clock-names = "du.0", "du.1", "du.2", "du.3",
 		      "dclkin.0", "dclkin.1", "dclkin.2", "dclkin.3";
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
index 446822f5751c..1620e8d8dacc 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-x.dts
@@ -40,12 +40,11 @@
 		 <&cpg CPG_MOD 723>,
 		 <&cpg CPG_MOD 722>,
 		 <&cpg CPG_MOD 721>,
-		 <&cpg CPG_MOD 727>,
 		 <&versaclock5 1>,
 		 <&x21_clk>,
 		 <&x22_clk>,
 		 <&versaclock5 2>;
-	clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0",
+	clock-names = "du.0", "du.1", "du.2", "du.3",
 		      "dclkin.0", "dclkin.1", "dclkin.2", "dclkin.3";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
index 8ded64d0a4d5..8c142affee49 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7795-salvator-xs.dts
@@ -40,12 +40,11 @@
 		 <&cpg CPG_MOD 723>,
 		 <&cpg CPG_MOD 722>,
 		 <&cpg CPG_MOD 721>,
-		 <&cpg CPG_MOD 727>,
 		 <&versaclock6 1>,
 		 <&x21_clk>,
 		 <&x22_clk>,
 		 <&versaclock6 2>;
-	clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0",
+	clock-names = "du.0", "du.1", "du.2", "du.3",
 		      "dclkin.0", "dclkin.1", "dclkin.2", "dclkin.3";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7795.dtsi b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
index aa0d4c8f6b04..efc24770c0fd 100644
--- a/arch/arm64/boot/dts/renesas/r8a7795.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7795.dtsi
@@ -2782,9 +2782,7 @@
 
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a7795";
-			reg = <0 0xfeb00000 0 0x80000>,
-			      <0 0xfeb90000 0 0x14>;
-			reg-names = "du", "lvds.0";
+			reg = <0 0xfeb00000 0 0x80000>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>,
@@ -2792,9 +2790,8 @@
 			clocks = <&cpg CPG_MOD 724>,
 				 <&cpg CPG_MOD 723>,
 				 <&cpg CPG_MOD 722>,
-				 <&cpg CPG_MOD 721>,
-				 <&cpg CPG_MOD 727>;
-			clock-names = "du.0", "du.1", "du.2", "du.3", "lvds.0";
+				 <&cpg CPG_MOD 721>;
+			clock-names = "du.0", "du.1", "du.2", "du.3";
 			vsps = <&vspd0 0 &vspd1 0 &vspd2 0 &vspd0 1>;
 			status = "disabled";
 
@@ -2822,6 +2819,33 @@
 				port at 3 {
 					reg = <3>;
 					du_out_lvds0: endpoint {
+						remote-endpoint = <&lvds0_in>;
+					};
+				};
+			};
+		};
+
+		lvds0: lvds at feb90000 {
+			compatible = "renesas,r8a7795-lvds";
+			reg = <0 0xfeb90000 0 0x14>;
+			clocks = <&cpg CPG_MOD 727>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			resets = <&cpg 727>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					lvds0_in: endpoint {
+						remote-endpoint = <&du_out_lvds0>;
+					};
+				};
+				port at 1 {
+					reg = <1>;
+					lvds0_out: endpoint {
 					};
 				};
 			};
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
index cbd8acbf537e..9e4594c27fa6 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-m3ulcb.dts
@@ -30,10 +30,9 @@
 	clocks = <&cpg CPG_MOD 724>,
 		 <&cpg CPG_MOD 723>,
 		 <&cpg CPG_MOD 722>,
-		 <&cpg CPG_MOD 727>,
 		 <&versaclock5 1>,
 		 <&versaclock5 3>,
 		 <&versaclock5 2>;
-	clock-names = "du.0", "du.1", "du.2", "lvds.0",
+	clock-names = "du.0", "du.1", "du.2",
 		      "dclkin.0", "dclkin.1", "dclkin.2";
 };
diff --git a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
index 052d72acc862..b4f9567cb9f8 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
+++ b/arch/arm64/boot/dts/renesas/r8a7796-salvator-x.dts
@@ -29,11 +29,10 @@
 	clocks = <&cpg CPG_MOD 724>,
 		 <&cpg CPG_MOD 723>,
 		 <&cpg CPG_MOD 722>,
-		 <&cpg CPG_MOD 727>,
 		 <&versaclock5 1>,
 		 <&x21_clk>,
 		 <&versaclock5 2>;
-	clock-names = "du.0", "du.1", "du.2", "lvds.0",
+	clock-names = "du.0", "du.1", "du.2",
 		      "dclkin.0", "dclkin.1", "dclkin.2";
 };
 
diff --git a/arch/arm64/boot/dts/renesas/r8a7796.dtsi b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
index b93596c9c6b1..258a3271b002 100644
--- a/arch/arm64/boot/dts/renesas/r8a7796.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a7796.dtsi
@@ -2437,17 +2437,14 @@
 
 		du: display at feb00000 {
 			compatible = "renesas,du-r8a7796";
-			reg = <0 0xfeb00000 0 0x70000>,
-			      <0 0xfeb90000 0 0x14>;
-			reg-names = "du", "lvds.0";
+			reg = <0 0xfeb00000 0 0x70000>;
 			interrupts = <GIC_SPI 256 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>,
 				     <GIC_SPI 269 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&cpg CPG_MOD 724>,
 				 <&cpg CPG_MOD 723>,
-				 <&cpg CPG_MOD 722>,
-				 <&cpg CPG_MOD 727>;
-			clock-names = "du.0", "du.1", "du.2", "lvds.0";
+				 <&cpg CPG_MOD 722>;
+			clock-names = "du.0", "du.1", "du.2";
 			status = "disabled";
 
 			vsps = <&vspd0 &vspd1 &vspd2>;
@@ -2470,6 +2467,33 @@
 				port at 2 {
 					reg = <2>;
 					du_out_lvds0: endpoint {
+						remote-endpoint = <&lvds0_in>;
+					};
+				};
+			};
+		};
+
+		lvds0: lvds at feb90000 {
+			compatible = "renesas,r8a7796-lvds";
+			reg = <0 0xfeb90000 0 0x14>;
+			clocks = <&cpg CPG_MOD 727>;
+			power-domains = <&sysc R8A7796_PD_ALWAYS_ON>;
+			resets = <&cpg 727>;
+			status = "disabled";
+
+			ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
+					reg = <0>;
+					lvds0_in: endpoint {
+						remote-endpoint = <&du_out_lvds0>;
+					};
+				};
+				port at 1 {
+					reg = <1>;
+					lvds0_out: endpoint {
 					};
 				};
 			};
-- 
2.11.0
