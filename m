From: damien.riegel@savoirfairelinux.com (Damien Riegel)
Date: Thu,  7 Dec 2017 10:19:41 -0500
Subject: [PATCH v2 09/10] arm64: dts: qcom: msm8916: normalize I2C and SPI
 nodes
In-Reply-To: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
References: <20171207151942.5805-1-damien.riegel@savoirfairelinux.com>
Message-ID: <20171207151942.5805-10-damien.riegel@savoirfairelinux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The QUP core can be used either for I2C or SPI, so the same IP is mapped
by a driver or the other. SPI bindings use a leading 0 for the start
address and a size of 0x600, I2C bindings don't have the leading 0 and
have a size 0x1000.

To make them more similar, add the leading 0 to I2C bindings and changes
the size to 0x500 for all of them, as this is the actual size of these
blocks. Also align the second entry of the clocks array.

Signed-off-by: Damien Riegel <damien.riegel@savoirfairelinux.com>
---
Changes in v2:
 - Set size to 0x500

 arch/arm64/boot/dts/qcom/msm8916.dtsi | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/msm8916.dtsi b/arch/arm64/boot/dts/qcom/msm8916.dtsi
index e16ba8334518..ac440f287633 100644
--- a/arch/arm64/boot/dts/qcom/msm8916.dtsi
+++ b/arch/arm64/boot/dts/qcom/msm8916.dtsi
@@ -355,7 +355,7 @@
 
 		blsp_spi1: spi at 78b5000 {
 			compatible = "qcom,spi-qup-v2.2.1";
-			reg = <0x078b5000 0x600>;
+			reg = <0x078b5000 0x500>;
 			interrupts = <GIC_SPI 95 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP1_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
@@ -372,7 +372,7 @@
 
 		blsp_spi2: spi at 78b6000 {
 			compatible = "qcom,spi-qup-v2.2.1";
-			reg = <0x078b6000 0x600>;
+			reg = <0x078b6000 0x500>;
 			interrupts = <GIC_SPI 96 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP2_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
@@ -389,7 +389,7 @@
 
 		blsp_spi3: spi at 78b7000 {
 			compatible = "qcom,spi-qup-v2.2.1";
-			reg = <0x078b7000 0x600>;
+			reg = <0x078b7000 0x500>;
 			interrupts = <GIC_SPI 97 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP3_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
@@ -406,7 +406,7 @@
 
 		blsp_spi4: spi at 78b8000 {
 			compatible = "qcom,spi-qup-v2.2.1";
-			reg = <0x078b8000 0x600>;
+			reg = <0x078b8000 0x500>;
 			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP4_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
@@ -423,7 +423,7 @@
 
 		blsp_spi5: spi at 78b9000 {
 			compatible = "qcom,spi-qup-v2.2.1";
-			reg = <0x078b9000 0x600>;
+			reg = <0x078b9000 0x500>;
 			interrupts = <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP5_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
@@ -440,7 +440,7 @@
 
 		blsp_spi6: spi at 78ba000 {
 			compatible = "qcom,spi-qup-v2.2.1";
-			reg = <0x078ba000 0x600>;
+			reg = <0x078ba000 0x500>;
 			interrupts = <GIC_SPI 100 IRQ_TYPE_LEVEL_HIGH>;
 			clocks = <&gcc GCC_BLSP1_QUP6_SPI_APPS_CLK>,
 				 <&gcc GCC_BLSP1_AHB_CLK>;
@@ -457,10 +457,10 @@
 
 		blsp_i2c2: i2c at 78b6000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x78b6000 0x1000>;
+			reg = <0x078b6000 0x500>;
 			interrupts = <GIC_SPI 96 0>;
 			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				<&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
 			clock-names = "iface", "core";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c2_default>;
@@ -472,10 +472,10 @@
 
 		blsp_i2c4: i2c at 78b8000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x78b8000 0x1000>;
+			reg = <0x078b8000 0x500>;
 			interrupts = <GIC_SPI 98 0>;
 			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				<&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
+				 <&gcc GCC_BLSP1_QUP4_I2C_APPS_CLK>;
 			clock-names = "iface", "core";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c4_default>;
@@ -487,10 +487,10 @@
 
 		blsp_i2c6: i2c at 78ba000 {
 			compatible = "qcom,i2c-qup-v2.2.1";
-			reg = <0x78ba000 0x1000>;
+			reg = <0x078ba000 0x500>;
 			interrupts = <GIC_SPI 100 0>;
 			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
-				<&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>;
+				 <&gcc GCC_BLSP1_QUP6_I2C_APPS_CLK>;
 			clock-names = "iface", "core";
 			pinctrl-names = "default", "sleep";
 			pinctrl-0 = <&i2c6_default>;
-- 
2.15.0
