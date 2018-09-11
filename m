From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 11 Sep 2018 11:17:02 +0100
Subject: [PATCH 01/11] Documentation: dts: Update coresight binding examples
In-Reply-To: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
References: <1536661032-30481-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <1536661032-30481-2-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While we updated the coresight DT bindings, some of the
new examples were not updated due to the order in which they
were merged. Let us update all the missed out ones to the
new bindings to avoid confusion.

Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Signed-off-by: Suzuki K Poulose <suzuki.poulose@arm.com>
---
 Documentation/devicetree/bindings/arm/coresight.txt | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/Documentation/devicetree/bindings/arm/coresight.txt b/Documentation/devicetree/bindings/arm/coresight.txt
index f39d2c6..3b689e0 100644
--- a/Documentation/devicetree/bindings/arm/coresight.txt
+++ b/Documentation/devicetree/bindings/arm/coresight.txt
@@ -147,7 +147,7 @@ Example:
 
 		clocks = <&oscclk6a>;
 		clock-names = "apb_pclk";
-		ports {
+		in-ports {
 			#address-cells = <1>;
 			#size-cells = <0>;
 
@@ -159,10 +159,15 @@ Example:
 					remote-endpoint = <&replicator2_out_port0>;
 				};
 			};
+		};
+
+		out-ports {
+			#address-cells = <1>;
+			#size-cells = <0>;
 
 			/* CATU link represented by output port */
-			port at 1 {
-				reg = <1>;
+			port at 0 {
+				reg = <0>;
 				etr_out_port: endpoint {
 					remote-endpoint = <&catu_in_port>;
 				};
@@ -310,10 +315,11 @@ Example:
 		clock-names = "apb_pclk";
 
 		interrupts = <GIC_SPI 4 IRQ_TYPE_LEVEL_HIGH>;
-		port {
-			catu_in_port: endpoint {
-				slave-mode;
-				remote-endpoint = <&etr_out_port>;
+		in-ports {
+			port {
+				catu_in_port: endpoint {
+					remote-endpoint = <&etr_out_port>;
+				};
 			};
 		};
 	};
-- 
2.7.4
