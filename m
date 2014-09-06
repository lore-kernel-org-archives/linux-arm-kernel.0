From: broonie@kernel.org (Mark Brown)
Date: Sat,  6 Sep 2014 12:40:16 +0100
Subject: [PATCH] ARM: zynq: Add ISL9305 regulator on Parallella board
Message-ID: <1410003616-32077-1-git-send-email-broonie@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is an ISL9305 regulator on the Parallella board, add it to the DT
along with descriptions of all the supplies.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm/boot/dts/zynq-parallella.dts | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 41afd9da6876..43ca89fb92e4 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -53,6 +53,29 @@
 
 &i2c0 {
 	status = "okay";
+
+	isl9305: isl9305 at 68 {
+		compatible = "isl,isl9305";
+		reg = <0x68>;
+
+		regulators {
+			dcd1 {
+				regulator-name = "VDD_DSP";
+				regulator-always-on;
+			};
+			dcd2 {
+				regulator-name = "1P35V";
+				regulator-always-on;
+			};
+			ldo1 {
+				regulator-name = "VDD_ADJ";
+			};
+			ldo2 {
+				regulator-name = "VDD_GPIO";
+				regulator-always-on;
+			};
+		};
+	};
 };
 
 &sdhci1 {
-- 
2.1.0
