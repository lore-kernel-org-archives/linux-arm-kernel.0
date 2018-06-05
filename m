From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  5 Jun 2018 22:43:22 +0100
Subject: [PATCH 11/20] dts: hisilicon: Update coresight bindings for hw ports
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1528235011-30691-12-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to updated coresight bindings for hw ports.

Cc: xuwei5 at hisilicon.com
Cc: lipengcheng8 at huawei.com
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 .../arm64/boot/dts/hisilicon/hi6220-coresight.dtsi | 89 ++++++++++++++++------
 1 file changed, 64 insertions(+), 25 deletions(-)

diff --git a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
index 7afee5d..a394a65 100644
--- a/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
+++ b/arch/arm64/boot/dts/hisilicon/hi6220-coresight.dtsi
@@ -27,17 +27,20 @@
 				port at 0 {
 					reg = <0>;
 					soc_funnel_out: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&etf_in>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port at 1 {
-					reg = <0>;
+					reg = <1>;
 					soc_funnel_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&acpu_funnel_out>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -56,17 +59,20 @@
 				port at 0 {
 					reg = <0>;
 					etf_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&soc_funnel_out>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port at 1 {
-					reg = <0>;
+					reg = <1>;
 					etf_out: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&replicator_in>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -84,25 +90,30 @@
 				port at 0 {
 					reg = <0>;
 					replicator_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etf_out>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port at 1 {
-					reg = <0>;
+					reg = <1>;
 					replicator_out0: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&etr_in>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port at 2 {
-					reg = <1>;
+					reg = <2>;
 					replicator_out1: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&tpiu_in>;
+						coresight,hwid = <1>;
 					};
 				};
 			};
@@ -121,9 +132,10 @@
 				port at 0 {
 					reg = <0>;
 					etr_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&replicator_out0>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -142,9 +154,10 @@
 				port at 0 {
 					reg = <0>;
 					tpiu_in: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&replicator_out1>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -163,80 +176,90 @@
 				port at 0 {
 					reg = <0>;
 					acpu_funnel_out: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&soc_funnel_in>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port at 1 {
-					reg = <0>;
+					reg = <1>;
 					acpu_funnel_in0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm0_out>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port at 2 {
-					reg = <1>;
+					reg = <2>;
 					acpu_funnel_in1: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm1_out>;
+						coresight,hwid = <1>;
 					};
 				};
 
 				port at 3 {
-					reg = <2>;
+					reg = <3>;
 					acpu_funnel_in2: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm2_out>;
+						coresight,hwid = <2>;
 					};
 				};
 
 				port at 4 {
-					reg = <3>;
+					reg = <4>;
 					acpu_funnel_in3: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm3_out>;
+						coresight,hwid = <3>;
 					};
 				};
 
 				port at 5 {
-					reg = <4>;
+					reg = <5>;
 					acpu_funnel_in4: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm4_out>;
+						coresight,hwid = <4>;
 					};
 				};
 
 				port at 6 {
-					reg = <5>;
+					reg = <6>;
 					acpu_funnel_in5: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm5_out>;
+						coresight,hwid = <5>;
 					};
 				};
 
 				port at 7 {
-					reg = <6>;
+					reg = <7>;
 					acpu_funnel_in6: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm6_out>;
+						coresight,hwid = <6>;
 					};
 				};
 
 				port at 8 {
-					reg = <7>;
+					reg = <8>;
 					acpu_funnel_in7: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint =
 							<&etm7_out>;
+						coresight,hwid = <7>;
 					};
 				};
 			};
@@ -253,8 +276,10 @@
 
 			port {
 				etm0_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -270,8 +295,10 @@
 
 			port {
 				etm1_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -287,8 +314,10 @@
 
 			port {
 				etm2_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in2>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -304,8 +333,10 @@
 
 			port {
 				etm3_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in3>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -321,8 +352,10 @@
 
 			port {
 				etm4_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in4>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -338,8 +371,10 @@
 
 			port {
 				etm5_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in5>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -355,8 +390,10 @@
 
 			port {
 				etm6_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in6>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -372,8 +409,10 @@
 
 			port {
 				etm7_out: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&acpu_funnel_in7>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
-- 
2.7.4
