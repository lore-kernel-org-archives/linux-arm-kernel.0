From: sudeep.holla@arm.com (Sudeep Holla)
Date: Tue, 18 Sep 2018 12:18:55 +0100
Subject: [PATCH] ARM: dts: vexpress/TC2: Update entries to match latest
 coresight bindings
In-Reply-To: <1537269535-26081-1-git-send-email-sudeep.holla@arm.com>
References: <1537269535-26081-1-git-send-email-sudeep.holla@arm.com>
Message-ID: <1537269535-26081-2-git-send-email-sudeep.holla@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suzuki K Poulose <suzuki.poulose@arm.com>

Switch to the new coresight bindings

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
[sudeep.holla: updated title and fixed couple of remaining dtc warnings]
Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
---
 arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts | 94 ++++++++++++++++--------------
 1 file changed, 49 insertions(+), 45 deletions(-)

diff --git a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
index ac6b90e9d806..8b926c30ccd1 100644
--- a/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
+++ b/arch/arm/boot/dts/vexpress-v2p-ca15_a7.dts
@@ -393,10 +393,11 @@
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etb_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port0>;
+		in-ports {
+			port {
+				etb_in_port: endpoint {
+					remote-endpoint = <&replicator_out_port0>;
+				};
 			};
 		};
 	};
@@ -407,10 +408,11 @@
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			tpiu_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port1>;
+		in-ports {
+			port {
+				tpiu_in_port: endpoint {
+					remote-endpoint = <&replicator_out_port1>;
+				};
 			};
 		};
 	};
@@ -421,11 +423,10 @@
 		 */
 		compatible = "arm,coresight-replicator";
 
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
-			/* replicator output ports */
 			port at 0 {
 				reg = <0>;
 				replicator_out_port0: endpoint {
@@ -439,12 +440,11 @@
 					remote-endpoint = <&tpiu_in_port>;
 				};
 			};
+		};
 
-			/* replicator input port */
-			port at 2 {
-				reg = <0>;
+		in-ports {
+			port {
 				replicator_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&funnel_out_port0>;
 				};
 			};
@@ -457,40 +457,36 @@
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			/* funnel output port */
-			port at 0 {
-				reg = <0>;
+		out-ports {
+			port {
 				funnel_out_port0: endpoint {
 					remote-endpoint =
 						<&replicator_in_port0>;
 				};
 			};
+		};
 
-			/* funnel input ports */
-			port at 1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
 				reg = <0>;
 				funnel_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm0_out_port>;
 				};
 			};
 
-			port at 2 {
+			port at 1 {
 				reg = <1>;
 				funnel_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&ptm1_out_port>;
 				};
 			};
 
-			port at 3 {
+			port at 2 {
 				reg = <2>;
 				funnel_in_port2: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm0_out_port>;
 				};
 			};
@@ -500,7 +496,6 @@
 			port at 4 {
 				reg = <4>;
 				funnel_in_port4: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm1_out_port>;
 				};
 			};
@@ -508,7 +503,6 @@
 			port at 5 {
 				reg = <5>;
 				funnel_in_port5: endpoint {
-					slave-mode;
 					remote-endpoint = <&etm2_out_port>;
 				};
 			};
@@ -522,9 +516,11 @@
 		cpu = <&cpu0>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			ptm0_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port0>;
+		out-ports {
+			port {
+				ptm0_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port0>;
+				};
 			};
 		};
 	};
@@ -536,9 +532,11 @@
 		cpu = <&cpu1>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			ptm1_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port1>;
+		out-ports {
+			port {
+				ptm1_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port1>;
+				};
 			};
 		};
 	};
@@ -550,9 +548,11 @@
 		cpu = <&cpu2>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etm0_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port2>;
+		out-ports {
+			port {
+				etm0_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port2>;
+				};
 			};
 		};
 	};
@@ -564,9 +564,11 @@
 		cpu = <&cpu3>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etm1_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port4>;
+		out-ports {
+			port {
+				etm1_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port4>;
+				};
 			};
 		};
 	};
@@ -578,9 +580,11 @@
 		cpu = <&cpu4>;
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		port {
-			etm2_out_port: endpoint {
-				remote-endpoint = <&funnel_in_port5>;
+		out-ports {
+			port {
+				etm2_out_port: endpoint {
+					remote-endpoint = <&funnel_in_port5>;
+				};
 			};
 		};
 	};
-- 
2.7.4
