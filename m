From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Thu, 19 Jul 2018 11:55:14 +0100
Subject: [PATCH v2 10/10] dts: juno: Update coresight bindings for hw port
In-Reply-To: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
References: <1531997715-6767-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1531997715-6767-11-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to updated coresight bindings for hw ports.

Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Liviu Dudau <liviu.dudau@arm.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
Changes since V2:
  - Update to new format.
---
 arch/arm64/boot/dts/arm/juno-base.dtsi    | 161 +++++++++++++++---------------
 arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi |  52 ++++------
 arch/arm64/boot/dts/arm/juno.dts          |  13 +--
 3 files changed, 105 insertions(+), 121 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index ce56a4a..a418193 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -115,22 +115,17 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
 
-			/* input port */
-			port at 0 {
-				reg = <0>;
+		in-ports {
+			port {
 				etf0_in_port: endpoint {
-					slave-mode;
 					remote-endpoint = <&main_funnel_out_port>;
 				};
 			};
+		};
 
-			/* output port */
-			port at 1 {
-				reg = <0>;
+		out-ports {
+			port {
 				etf0_out_port: endpoint {
 				};
 			};
@@ -144,10 +139,11 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		port {
-			tpiu_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port0>;
+		in-ports {
+			port {
+				tpiu_in_port: endpoint {
+					remote-endpoint = <&replicator_out_port0>;
+				};
 			};
 		};
 	};
@@ -160,31 +156,29 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
 
-			/* output port */
-			port at 0 {
-				reg = <0>;
+		out-ports {
+			port {
 				main_funnel_out_port: endpoint {
 					remote-endpoint = <&etf0_in_port>;
 				};
 			};
+		};
 
-			/* input ports */
-			port at 1 {
+		main_funnel_in_ports: in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
 				reg = <0>;
 				main_funnel_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&cluster0_funnel_out_port>;
 				};
 			};
 
-			port at 2 {
+			port at 1 {
 				reg = <1>;
 				main_funnel_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&cluster1_funnel_out_port>;
 				};
 			};
@@ -199,10 +193,11 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		port {
-			etr_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&replicator_out_port1>;
+		in-ports {
+			port {
+				etr_in_port: endpoint {
+					remote-endpoint = <&replicator_out_port1>;
+				};
 			};
 		};
 	};
@@ -216,8 +211,10 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		port {
-			stm_out_port: endpoint {
+		out-ports {
+			port {
+				stm_out_port: endpoint {
+				};
 			};
 		};
 	};
@@ -238,9 +235,11 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		port {
-			cluster0_etm0_out_port: endpoint {
-				remote-endpoint = <&cluster0_funnel_in_port0>;
+		out-ports {
+			port {
+				cluster0_etm0_out_port: endpoint {
+					remote-endpoint = <&cluster0_funnel_in_port0>;
+				};
 			};
 		};
 	};
@@ -252,29 +251,28 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port at 0 {
-				reg = <0>;
+		out-ports {
+			port {
 				cluster0_funnel_out_port: endpoint {
 					remote-endpoint = <&main_funnel_in_port0>;
 				};
 			};
+		};
 
-			port at 1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
 				reg = <0>;
 				cluster0_funnel_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&cluster0_etm0_out_port>;
 				};
 			};
 
-			port at 2 {
+			port at 1 {
 				reg = <1>;
 				cluster0_funnel_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&cluster0_etm1_out_port>;
 				};
 			};
@@ -297,9 +295,11 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		port {
-			cluster0_etm1_out_port: endpoint {
-				remote-endpoint = <&cluster0_funnel_in_port1>;
+		out-ports {
+			port {
+				cluster0_etm1_out_port: endpoint {
+					remote-endpoint = <&cluster0_funnel_in_port1>;
+				};
 			};
 		};
 	};
@@ -320,9 +320,11 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		port {
-			cluster1_etm0_out_port: endpoint {
-				remote-endpoint = <&cluster1_funnel_in_port0>;
+		out-ports {
+			port {
+				cluster1_etm0_out_port: endpoint {
+					remote-endpoint = <&cluster1_funnel_in_port0>;
+				};
 			};
 		};
 	};
@@ -334,43 +336,40 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port at 0 {
-				reg = <0>;
+		out-ports {
+			port {
 				cluster1_funnel_out_port: endpoint {
 					remote-endpoint = <&main_funnel_in_port1>;
 				};
 			};
+		};
 
-			port at 1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+
+			port at 0 {
 				reg = <0>;
 				cluster1_funnel_in_port0: endpoint {
-					slave-mode;
 					remote-endpoint = <&cluster1_etm0_out_port>;
 				};
 			};
 
-			port at 2 {
+			port at 1 {
 				reg = <1>;
 				cluster1_funnel_in_port1: endpoint {
-					slave-mode;
 					remote-endpoint = <&cluster1_etm1_out_port>;
 				};
 			};
-			port at 3 {
+			port at 2 {
 				reg = <2>;
 				cluster1_funnel_in_port2: endpoint {
-					slave-mode;
 					remote-endpoint = <&cluster1_etm2_out_port>;
 				};
 			};
-			port at 4 {
+			port at 3 {
 				reg = <3>;
 				cluster1_funnel_in_port3: endpoint {
-					slave-mode;
 					remote-endpoint = <&cluster1_etm3_out_port>;
 				};
 			};
@@ -393,9 +392,11 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		port {
-			cluster1_etm1_out_port: endpoint {
-				remote-endpoint = <&cluster1_funnel_in_port1>;
+		out-ports {
+			port {
+				cluster1_etm1_out_port: endpoint {
+					remote-endpoint = <&cluster1_funnel_in_port1>;
+				};
 			};
 		};
 	};
@@ -416,9 +417,11 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		port {
-			cluster1_etm2_out_port: endpoint {
-				remote-endpoint = <&cluster1_funnel_in_port2>;
+		out-ports {
+			port {
+				cluster1_etm2_out_port: endpoint {
+					remote-endpoint = <&cluster1_funnel_in_port2>;
+				};
 			};
 		};
 	};
@@ -439,9 +442,11 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		port {
-			cluster1_etm3_out_port: endpoint {
-				remote-endpoint = <&cluster1_funnel_in_port3>;
+		out-ports {
+			port {
+				cluster1_etm3_out_port: endpoint {
+					remote-endpoint = <&cluster1_funnel_in_port3>;
+				};
 			};
 		};
 	};
@@ -454,7 +459,7 @@
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
 
-		ports {
+		out-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
@@ -472,12 +477,10 @@
 					remote-endpoint = <&etr_in_port>;
 				};
 			};
-
-			/* replicator input port */
-			port at 2 {
-				reg = <0>;
+		};
+		in-ports {
+			port {
 				replicator_in_port0: endpoint {
-					slave-mode;
 				};
 			};
 		};
diff --git a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
index 0c43fb3..cf28515 100644
--- a/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-cs-r1r2.dtsi
@@ -7,23 +7,16 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			/* output port */
-			port at 0 {
-				reg = <0>;
+		out-ports {
+			port {
 				csys1_funnel_out_port: endpoint {
 					remote-endpoint = <&etf1_in_port>;
 				};
 			};
-
-			/* input port */
-			port at 1 {
-				reg = <0>;
+		};
+		in-ports {
+			port {
 				csys1_funnel_in_port0: endpoint {
-					slave-mode;
 				};
 			};
 
@@ -37,22 +30,15 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			/* input port */
-			port at 0 {
-				reg = <0>;
+		in-ports {
+			port {
 				etf1_in_port: endpoint {
-					slave-mode;
 					remote-endpoint = <&csys1_funnel_out_port>;
 				};
 			};
-
-			/* output port */
-			port at 1 {
-				reg = <0>;
+		};
+		out-ports {
+			port {
 				etf1_out_port: endpoint {
 					remote-endpoint = <&csys2_funnel_in_port1>;
 				};
@@ -67,20 +53,18 @@
 		clocks = <&soc_smc50mhz>;
 		clock-names = "apb_pclk";
 		power-domains = <&scpi_devpd 0>;
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			/* output port */
-			port at 0 {
-				reg = <0>;
+		out-ports {
+			port {
 				csys2_funnel_out_port: endpoint {
 					remote-endpoint = <&replicator_in_port0>;
 				};
 			};
+		};
 
-			/* input ports */
-			port at 1 {
+		in-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
+			port at 0 {
 				reg = <0>;
 				csys2_funnel_in_port0: endpoint {
 					slave-mode;
@@ -88,7 +72,7 @@
 				};
 			};
 
-			port at 2 {
+			port at 1 {
 				reg = <1>;
 				csys2_funnel_in_port1: endpoint {
 					slave-mode;
diff --git a/arch/arm64/boot/dts/arm/juno.dts b/arch/arm64/boot/dts/arm/juno.dts
index 2b2bf39..eb55c2f 100644
--- a/arch/arm64/boot/dts/arm/juno.dts
+++ b/arch/arm64/boot/dts/arm/juno.dts
@@ -257,14 +257,11 @@
 	remote-endpoint = <&main_funnel_in_port2>;
 };
 
-&main_funnel {
-	ports {
-		port at 3 {
-			reg = <2>;
-			main_funnel_in_port2: endpoint {
-				slave-mode;
-				remote-endpoint = <&stm_out_port>;
-			};
+&main_funnel_in_ports {
+	port at 2 {
+		reg = <2>;
+		main_funnel_in_port2: endpoint {
+			remote-endpoint = <&stm_out_port>;
 		};
 	};
 };
-- 
2.7.4
