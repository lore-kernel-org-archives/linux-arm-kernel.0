From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 11 Sep 2018 11:17:05 +0100
Subject: [PATCH 04/11] dts: qcom: Update coresight bindings for hardware ports
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1536661032-30481-5-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to updated coresight bindings for hw ports

Cc: Andy Gross <andy.gross@linaro.org>
Cc: David Brown <david.brown@linaro.org>
Cc: Ivan T. Ivanov <ivan.ivanov@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm64/boot/dts/qcom/msm8916.dtsi | 98 ++++++++++++++++++++++-------------
 1 file changed, 63 insertions(+), 35 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index 7b32b89..5bed52b 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -1099,10 +1099,11 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			port {
-				tpiu_in: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out1>;
+			out-ports {
+				port {
+					tpiu_in: endpoint {
+						remote-endpoint = <&replicator_out1>;
+					};
 				};
 			};
 		};
@@ -1114,7 +1115,7 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1132,11 +1133,16 @@
 				port at 4 {
 					reg = <4>;
 					funnel0_in4: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel1_out>;
 					};
 				};
-				port at 8 {
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					funnel0_out: endpoint {
 						remote-endpoint = <&etf_in>;
@@ -1152,7 +1158,7 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			out-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
@@ -1162,16 +1168,22 @@
 						remote-endpoint = <&etr_in>;
 					};
 				};
+
 				port at 1 {
 					reg = <1>;
 					replicator_out1: endpoint {
 						remote-endpoint = <&tpiu_in>;
 					};
 				};
-				port at 2 {
+			};
+
+			in-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					replicator_in: endpoint {
-						slave-mode;
 						remote-endpoint = <&etf_out>;
 					};
 				};
@@ -1185,18 +1197,23 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
 				port at 0 {
 					reg = <0>;
 					etf_in: endpoint {
-						slave-mode;
 						remote-endpoint = <&funnel0_out>;
 					};
 				};
-				port at 1 {
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					etf_out: endpoint {
 						remote-endpoint = <&replicator_in>;
@@ -1212,10 +1229,11 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			port {
-				etr_in: endpoint {
-					slave-mode;
-					remote-endpoint = <&replicator_out0>;
+			in-ports {
+				port {
+					etr_in: endpoint {
+						remote-endpoint = <&replicator_out0>;
+					};
 				};
 			};
 		};
@@ -1227,39 +1245,41 @@
 			clocks = <&rpmcc RPM_QDSS_CLK>, <&rpmcc RPM_QDSS_A_CLK>;
 			clock-names = "apb_pclk", "atclk";
 
-			ports {
+			in-ports {
 				#address-cells = <1>;
 				#size-cells = <0>;
 
 				port at 0 {
 					reg = <0>;
 					funnel1_in0: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm0_out>;
 					};
 				};
 				port at 1 {
 					reg = <1>;
 					funnel1_in1: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm1_out>;
 					};
 				};
 				port at 2 {
 					reg = <2>;
 					funnel1_in2: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm2_out>;
 					};
 				};
 				port at 3 {
 					reg = <3>;
 					funnel1_in3: endpoint {
-						slave-mode;
 						remote-endpoint = <&etm3_out>;
 					};
 				};
-				port at 4 {
+			};
+
+			out-ports {
+				#address-cells = <1>;
+				#size-cells = <0>;
+
+				port at 0 {
 					reg = <0>;
 					funnel1_out: endpoint {
 						remote-endpoint = <&funnel0_in4>;
@@ -1309,9 +1329,11 @@
 
 			cpu = <&CPU0>;
 
-			port {
-				etm0_out: endpoint {
-				remote-endpoint = <&funnel1_in0>;
+			out-ports {
+				port {
+					etm0_out: endpoint {
+						remote-endpoint = <&funnel1_in0>;
+					};
 				};
 			};
 		};
@@ -1325,9 +1347,11 @@
 
 			cpu = <&CPU1>;
 
-			port {
-				etm1_out: endpoint {
-					remote-endpoint = <&funnel1_in1>;
+			out-ports {
+				port {
+					etm1_out: endpoint {
+						remote-endpoint = <&funnel1_in1>;
+					};
 				};
 			};
 		};
@@ -1341,9 +1365,11 @@
 
 			cpu = <&CPU2>;
 
-			port {
-				etm2_out: endpoint {
-					remote-endpoint = <&funnel1_in2>;
+			out-ports {
+				port {
+					etm2_out: endpoint {
+						remote-endpoint = <&funnel1_in2>;
+					};
 				};
 			};
 		};
@@ -1357,9 +1383,11 @@
 
 			cpu = <&CPU3>;
 
-			port {
-				etm3_out: endpoint {
-					remote-endpoint = <&funnel1_in3>;
+			out-ports {
+				port {
+					etm3_out: endpoint {
+						remote-endpoint = <&funnel1_in3>;
+					};
 				};
 			};
 		};
-- 
2.7.4
