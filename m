From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue,  5 Jun 2018 22:43:30 +0100
Subject: [PATCH 19/20] dts: ste-dbx5x0: Update coresight bindings for hardware
 port
In-Reply-To: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
References: <1528235011-30691-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1528235011-30691-20-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Switch to the new coresight bindings

Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 arch/arm/boot/dts/ste-dbx5x0.dtsi | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/arch/arm/boot/dts/ste-dbx5x0.dtsi b/arch/arm/boot/dts/ste-dbx5x0.dtsi
index 2310a4e..a02312a 100644
--- a/arch/arm/boot/dts/ste-dbx5x0.dtsi
+++ b/arch/arm/boot/dts/ste-dbx5x0.dtsi
@@ -69,7 +69,9 @@
 			cpu = <&CPU0>;
 			port {
 				ptm0_out_port: endpoint {
+					direction = <1>;
 					remote-endpoint = <&funnel_in_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -83,7 +85,9 @@
 			cpu = <&CPU1>;
 			port {
 				ptm1_out_port: endpoint {
+					direction = <1>;
 					remote-endpoint = <&funnel_in_port1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -102,25 +106,29 @@
 				port at 0 {
 					reg = <0>;
 					funnel_out_port: endpoint {
+						direction = <1>;
 						remote-endpoint =
 							<&replicator_in_port0>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				/* funnel input ports */
 				port at 1 {
-					reg = <0>;
+					reg = <1>;
 					funnel_in_port0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&ptm0_out_port>;
+						coresight,hwid = <0>;
 					};
 				};
 
 				port at 2 {
-					reg = <1>;
+					reg = <2>;
 					funnel_in_port1: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&ptm1_out_port>;
+						coresight,hwid = <1>;
 					};
 				};
 			};
@@ -139,22 +147,27 @@
 				port at 0 {
 					reg = <0>;
 					replicator_out_port0: endpoint {
+						direction = <1>;
 						remote-endpoint = <&tpiu_in_port>;
+						coresight,hwid = <0>;
 					};
 				};
 				port at 1 {
 					reg = <1>;
 					replicator_out_port1: endpoint {
+						direction = <1>;
 						remote-endpoint = <&etb_in_port>;
+						coresight,hwid = <1>;
 					};
 				};
 
 				/* replicator input port */
 				port at 2 {
-					reg = <0>;
+					reg = <2>;
 					replicator_in_port0: endpoint {
-						slave-mode;
+						direction = <0>;
 						remote-endpoint = <&funnel_out_port>;
+						coresight,hwid = <0>;
 					};
 				};
 			};
@@ -168,8 +181,9 @@
 			clock-names = "apb_pclk", "atclk";
 			port {
 				tpiu_in_port: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&replicator_out_port0>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
@@ -182,8 +196,9 @@
 			clock-names = "apb_pclk", "atclk";
 			port {
 				etb_in_port: endpoint {
-					slave-mode;
+					direction = <0>;
 					remote-endpoint = <&replicator_out_port1>;
+					coresight,hwid = <0>;
 				};
 			};
 		};
-- 
2.7.4
