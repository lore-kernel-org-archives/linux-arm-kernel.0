From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  5 Jun 2018 22:43:26 +0100
Subject: [PATCH 15/20] dts: arm: imx7{d,
 s}: Update coresight binding for hardware ports
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1528235011-30691-16-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the updated coresight bindings.

Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <fabio.estevam@nxp.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/imx7d.dtsi |  5 ++++-
 arch/arm/boot/dts/imx7s.dtsi | 41 ++++++++++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/imx7d.dtsi b/arch/arm/boot/dts/imx7d.dtsi
index 200714e..5faff17 100644
--- a/arch/arm/boot/dts/imx7d.dtsi
+++ b/arch/arm/boot/dts/imx7d.dtsi
@@ -87,7 +87,9 @@
 
 			port {
 				etm1_out_port: endpoint {
+					direction = <1>;
 					remote-endpoint = <&ca_funnel_in_port1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -174,8 +176,9 @@
 	port at 1 {
 		reg = <1>;
 		ca_funnel_in_port1: endpoint {
-			slave-mode;
+			direction = <0>;
 			remote-endpoint = <&etm1_out_port>;
+			coresight,hwid = <1>;
 		};
 	};
 };
diff --git a/arch/arm/boot/dts/imx7s.dtsi b/arch/arm/boot/dts/imx7s.dtsi
index 4d42335..8e90915 100644
--- a/arch/arm/boot/dts/imx7s.dtsi
+++ b/arch/arm/boot/dts/imx7s.dtsi
@@ -151,23 +151,28 @@
 			port at 0 {
 				reg = <0>;
 				replicator_out_port0: endpoint {
+					direction = <1>;
 					remote-endpoint = <&tpiu_in_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port at 1 {
 				reg = <1>;
 				replicator_out_port1: endpoint {
+					direction = <1>;
 					remote-endpoint = <&etr_in_port>;
+					coresight,hwid = <1>;
 				};
 			};
 
 			/* replicator input port */
 			port at 2 {
-				reg = <0>;
+				reg = <2>;
 				replicator_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&etf_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -203,16 +208,19 @@
 				port at 0 {
 					reg = <0>;
 					ca_funnel_in_port0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&etm0_out_port>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				/* funnel output port */
 				port at 2 {
-					reg = <0>;
+					reg = <2>;
 					ca_funnel_out_port0: endpoint {
+						direction = <1>;
 						remote-endpoint = <&hugo_funnel_in_port0>;
+						coresight,hwid = <0>;
 					};
 				};
 
@@ -229,7 +237,9 @@
 
 			port {
 				etm0_out_port: endpoint {
+					direction = <1>;
 					remote-endpoint = <&ca_funnel_in_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -248,22 +258,26 @@
 				port at 0 {
 					reg = <0>;
 					hugo_funnel_in_port0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&ca_funnel_out_port0>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port at 1 {
 					reg = <1>;
 					hugo_funnel_in_port1: endpoint {
-						slave-mode; /* M4 input */
+						direction = <0>; /* M4 input */
+						coresight,hwid = <1>;
 					};
 				};
 
 				port at 2 {
-					reg = <0>;
+					reg = <2>;
 					hugo_funnel_out_port0: endpoint {
+						direction = <1>;
 						remote-endpoint = <&etf_in_port>;
+						coresight,hwid = <0>;
 					};
 				};
 
@@ -284,15 +298,18 @@
 				port at 0 {
 					reg = <0>;
 					etf_in_port: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&hugo_funnel_out_port0>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port at 1 {
-					reg = <0>;
+					reg = <1>;
 					etf_out_port: endpoint {
+						direction = <1>;
 						remote-endpoint = <&replicator_in_port0>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -306,8 +323,9 @@
 
 			port {
 				etr_in_port: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&replicator_out_port1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -320,8 +338,9 @@
 
 			port {
 				tpiu_in_port: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&replicator_out_port1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
-- 
2.7.4
