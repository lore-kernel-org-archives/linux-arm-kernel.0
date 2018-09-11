From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 11 Sep 2018 11:17:11 +0100
Subject: [PATCH 10/11] dts: ste-dbx5x0: Update coresight bindings for hardware
 port
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1536661032-30481-11-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the new coresight bindings

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 61 ++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 26 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 2310a4e..b1d5d3e 100644
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
@@ -94,11 +98,10 @@
 
 			clocks = <&prcmu_clk PRCMU_APETRACECLK>, <&prcmu_clk PRCMU_APEATCLK>;
 			clock-names = "apb_pclk", "atclk";
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
-				/* funnel output ports */
 				port at 0 {
 					reg = <0>;
 					funnel_out_port: endpoint {
@@ -106,20 +109,22 @@
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
@@ -131,11 +136,10 @@
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
@@ -148,12 +152,15 @@
 						remote-endpoint = <&etb_in_port>;
 					};
 				};
+			};
 
-				/* replicator input port */
-				port at 2 {
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					replicator_in_port0: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel_out_port>;
 					};
 				};
@@ -166,10 +173,11 @@
 
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
@@ -180,10 +188,11 @@
 
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
2.7.4
