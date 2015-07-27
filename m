From: srinivas.kandagatla@linaro.org (Srinivas Kandagatla)
Date: Mon, 27 Jul 2015 14:50:02 +0100
Subject: [PATCH v1 1/7] ARM: dts: apq8064: remove temporary fixed regulator
 for mmc
In-Reply-To: <1438004945-16175-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1438004945-16175-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <1438005002-16219-1-git-send-email-srinivas.kandagatla@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes temporary fixed regluator use for mmc.
Board files should use the regulators which are wiredup appropriately.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 arch/arm/boot/dts/qcom-apq8064.dtsi | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/arch/arm/boot/dts/qcom-apq8064.dtsi b/arch/arm/boot/dts/qcom-apq8064.dtsi
index df2061e..1e1706e 100644
--- a/arch/arm/boot/dts/qcom-apq8064.dtsi
+++ b/arch/arm/boot/dts/qcom-apq8064.dtsi
@@ -448,14 +448,6 @@
 		};
 
 		/* Temporary fixed regulator */
-		vsdcc_fixed: vsdcc-regulator {
-			compatible = "regulator-fixed";
-			regulator-name = "SDCC Power";
-			regulator-min-microvolt = <2700000>;
-			regulator-max-microvolt = <2700000>;
-			regulator-always-on;
-		};
-
 		sdcc1bam:dma at 12402000{
 			compatible = "qcom,bam-v1.3.0";
 			reg = <0x12402000 0x8000>;
@@ -505,7 +497,6 @@
 				non-removable;
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
-				vmmc-supply = <&vsdcc_fixed>;
 				dmas = <&sdcc1bam 2>, <&sdcc1bam 1>;
 				dma-names = "tx", "rx";
 			};
@@ -524,7 +515,6 @@
 				cap-mmc-highspeed;
 				max-frequency	= <192000000>;
 				no-1-8-v;
-				vmmc-supply = <&vsdcc_fixed>;
 				dmas = <&sdcc3bam 2>, <&sdcc3bam 1>;
 				dma-names = "tx", "rx";
 			};
@@ -542,8 +532,6 @@
 				cap-sd-highspeed;
 				cap-mmc-highspeed;
 				max-frequency	= <48000000>;
-				vmmc-supply = <&vsdcc_fixed>;
-				vqmmc-supply = <&vsdcc_fixed>;
 				dmas = <&sdcc4bam 2>, <&sdcc4bam 1>;
 				dma-names = "tx", "rx";
 				pinctrl-names = "default";
-- 
1.9.1
