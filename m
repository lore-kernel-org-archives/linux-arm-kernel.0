From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  5 Jun 2018 22:43:31 +0100
Subject: [PATCH 20/20] dts: tc2: Update coresight bindings for hardware ports
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1528235011-30691-21-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the new coresight bindings

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 48 ++++++++++++++++++++++--------
 1 file changed, 36 insertions(+), 12 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index a4c7713..407693e 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -394,8 +394,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etb_in_port: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&replicator_out_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -408,8 +409,9 @@
 		clock-names = "apb_pclk";
 		port {
 			tpiu_in_port: endpoint {
-				slave-mode;
+				direction = <0>;
 				remote-endpoint = <&replicator_out_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -428,23 +430,28 @@
 			port at 0 {
 				reg = <0>;
 				replicator_out_port0: endpoint {
+					direction = <1>;
 					remote-endpoint = <&etb_in_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port at 1 {
 				reg = <1>;
 				replicator_out_port1: endpoint {
+					direction = <1>;
 					remote-endpoint = <&tpiu_in_port>;
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
 					remote-endpoint = <&funnel_out_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -464,33 +471,38 @@
 			port at 0 {
 				reg = <0>;
 				funnel_out_port0: endpoint {
+					direction = <1>;
 					remote-endpoint =
 						<&replicator_in_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			/* funnel input ports */
 			port at 1 {
-				reg = <0>;
+				reg = <1>;
 				funnel_in_port0: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm0_out_port>;
+					coresight,hwid = <0>;
 				};
 			};
 
 			port at 2 {
-				reg = <1>;
+				reg = <2>;
 				funnel_in_port1: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&ptm1_out_port>;
+					coresight,hwid = <1>;
 				};
 			};
 
 			port at 3 {
-				reg = <2>;
+				reg = <3>;
 				funnel_in_port2: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&etm0_out_port>;
+					coresight,hwid = <2>;
 				};
 			};
 
@@ -499,16 +511,18 @@
 			port at 4 {
 				reg = <4>;
 				funnel_in_port4: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&etm1_out_port>;
+					coresight,hwid = <4>;
 				};
 			};
 
 			port at 5 {
 				reg = <5>;
 				funnel_in_port5: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&etm2_out_port>;
+					coresight,hwid = <5>;
 				};
 			};
 		};
@@ -523,7 +537,9 @@
 		clock-names = "apb_pclk";
 		port {
 			ptm0_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port0>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -537,7 +553,9 @@
 		clock-names = "apb_pclk";
 		port {
 			ptm1_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port1>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -551,7 +569,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm0_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port2>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -565,7 +585,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm1_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port4>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
@@ -579,7 +601,9 @@
 		clock-names = "apb_pclk";
 		port {
 			etm2_out_port: endpoint {
+				direction = <1>;
 				remote-endpoint = <&funnel_in_port5>;
+				coresight,hwid = <0>;
 			};
 		};
 	};
-- 
2.7.4
