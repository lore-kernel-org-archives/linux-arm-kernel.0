From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed, 12 Sep 2018 14:53:52 +0100
Subject: [PATCH v2 11/11] arm: dts: ste-dbx5x0: Update coresight bindings for
 hardware port
In-Reply-To: <20180912135352.19722-1-suzuki.poulose@arm.com>
References: <20180912135352.19722-1-suzuki.poulose@arm.com>
Message-ID: <20180912135352.19722-12-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the new coresight bindings

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 65 ++++++++++++++++---------------
 1 file changed, 33 insertions(+), 32 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 2310a4e97768..7f94b5a53205 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -67,9 +67,11 @@
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			cpu = <&CPU0>;
-			port {
-				ptm0_out_port: endpoint {
-					remote-endpoint = <&funnel_in_port0>;
+			out-ports {
+				port {
+					ptm0_out_port: endpoint {
+						remote-endpoint = <&funnel_in_port0>;
+					};
 				};
 			};
 		};
@@ -81,9 +83,11 @@
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
 			cpu = <&CPU1>;
-			port {
-				ptm1_out_port: endpoint {
-					remote-endpoint = <&funnel_in_port1>;
+			out-ports {
+				port {
+					ptm1_out_port: endpoint {
+						remote-endpoint = <&funnel_in_port1>;
+					};
 				};
 			};
 		};
@@ -94,32 +98,29 @@
 
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
-			ports {
-				#address-cells = <1>;
-				#size-cells = <0>;
-
-				/* funnel output ports */
-				port at 0 {
-					reg = <0>;
+			out-ports {
+				port {
 					funnel_out_port: endpoint {
 						remote-endpoint =
 							<&replicator_in_port0>;
 					};
 				};
+			};
 
-				/* funnel input ports */
-				port at 1 {
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					funnel_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint = <&ptm0_out_port>;
 					};
 				};
 
-				port at 2 {
+				port at 1 {
 					reg = <1>;
 					funnel_in_port1: endpoint {
-						slave-mode;
 						remote-endpoint = <&ptm1_out_port>;
 					};
 				};
@@ -131,11 +132,10 @@
 			clocks = <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "atclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				/* replicator output ports */
 				port at 0 {
 					reg = <0>;
 					replicator_out_port0: endpoint {
@@ -148,12 +148,11 @@
 						remote-endpoint = <&etb_in_port>;
 					};
 				};
+			};
 
-				/* replicator input port */
-				port at 2 {
-					reg = <0>;
+			in-ports {
+				port {
 					replicator_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel_out_port>;
 					};
 				};
@@ -166,10 +165,11 @@
 
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
-			port {
-				tpiu_in_port: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out_port0>;
+			in-ports {
+				port {
+					tpiu_in_port: endpoint {
+						remote-endpoint = <&replicator_out_port0>;
+					};
 				};
 			};
 		};
@@ -180,10 +180,11 @@
 
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
-			port {
-				etb_in_port: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out_port1>;
+			in-ports {
+				port {
+					etb_in_port: endpoint {
+						remote-endpoint = <&replicator_out_port1>;
+					};
 				};
 			};
 		};
-- 
2.19.0
