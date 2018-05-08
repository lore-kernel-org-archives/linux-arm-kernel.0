From: robh@kernel.org (Rob Herring)
Date: Tue,  8 May 2018 10:09:49 -0500
Subject: [PATCH] arm64: dts: juno: fix OF graph endpoint node names
Message-ID: <20180508150952.24562-1-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OF graph endpoint node names should be 'endpoint'. Fix the following
warnings found by dtc:

Warning (graph_endpoint): /hdlcd at 7ff50000/port/hdlcd1-endpoint: graph endpont node nameshould be 'endpoint'
Warning (graph_endpoint): /hdlcd at 7ff60000/port/hdlcd0-endpoint: graph endpont node nameshould be 'endpoint'
Warning (graph_endpoint): /i2c at 7ffa0000/hdmi-transmitter at 70/port/tda998x-0-endpoint: graph endpont node name should be 'endpoint'
Warning (graph_endpoint): /i2c at 7ffa0000/hdmi-transmitter at 71/port/tda998x-1-endpoint: graph endpont node name should be 'endpoint'

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 arch/arm64/boot/dts/arm/juno-base.dtsi | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm64/boot/dts/arm/juno-base.dtsi b/arch/arm64/boot/dts/arm/juno-base.dtsi
index eb749c50a736..b2fedaab3fcc 100644
--- a/arch/arm64/boot/dts/arm/juno-base.dtsi
+++ b/arch/arm64/boot/dts/arm/juno-base.dtsi
@@ -677,7 +677,7 @@
 		clock-names = "pxlclk";
 
 		port {
-			hdlcd1_output: hdlcd1-endpoint {
+			hdlcd1_output: endpoint {
 				remote-endpoint = <&tda998x_1_input>;
 			};
 		};
@@ -692,7 +692,7 @@
 		clock-names = "pxlclk";
 
 		port {
-			hdlcd0_output: hdlcd0-endpoint {
+			hdlcd0_output: endpoint {
 				remote-endpoint = <&tda998x_0_input>;
 			};
 		};
@@ -720,7 +720,7 @@
 			compatible = "nxp,tda998x";
 			reg = <0x70>;
 			port {
-				tda998x_0_input: tda998x-0-endpoint {
+				tda998x_0_input: endpoint {
 					remote-endpoint = <&hdlcd0_output>;
 				};
 			};
@@ -730,7 +730,7 @@
 			compatible = "nxp,tda998x";
 			reg = <0x71>;
 			port {
-				tda998x_1_input: tda998x-1-endpoint {
+				tda998x_1_input: endpoint {
 					remote-endpoint = <&hdlcd1_output>;
 				};
 			};
-- 
2.17.0
