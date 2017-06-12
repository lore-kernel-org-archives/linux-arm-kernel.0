From: chunkeey@googlemail.com (Christian Lamparter)
Date: Mon, 12 Jun 2017 17:07:46 +0200
Subject: [PATCH] qcom: ipq4019: add second i2c
Message-ID: <20170612150746.25297-1-chunkeey@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the second i2c block to the IPQ4019 platform.
The second i2c has been successfully tested on the
Cisco Meraki MR33.

Cc: Chris Blake <chrisrblake93@gmail.com>
Cc: Matthew McClintock <msm-oss@mcclintock.net>
Signed-off-by: Christian Lamparter <chunkeey@googlemail.com>
---
 arch/arm/boot/dts/qcom-ipq4019.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-ipq4019.dtsi b/arch/arm/boot/dts/qcom-ipq4019.dtsi
index 4b7d97275c62..d8c87faa0124 100644
--- a/arch/arm/boot/dts/qcom-ipq4019.dtsi
+++ b/arch/arm/boot/dts/qcom-ipq4019.dtsi
@@ -26,6 +26,7 @@
 	aliases {
 		spi0 = &spi_0;
 		i2c0 = &i2c_0;
+		i2c1 = &i2c_1;
 	};
 
 	cpus {
@@ -164,6 +165,19 @@
 			status = "disabled";
 		};
 
+		i2c_1: i2c at 78b8000 {
+			compatible = "qcom,i2c-qup-v2.2.1";
+			reg = <0x78b8000 0x600>;
+			interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&gcc GCC_BLSP1_AHB_CLK>,
+				 <&gcc GCC_BLSP1_QUP2_I2C_APPS_CLK>;
+			clock-names = "iface", "core";
+			dmas = <&blsp_dma 11>, <&blsp_dma 10>;
+			dma-names = "rx", "tx";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			status = "disabled";
+		};
 
 		cryptobam: dma at 8e04000 {
 			compatible = "qcom,bam-v1.7.0";
-- 
2.11.0
