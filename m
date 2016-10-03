From: maitysanchayan@gmail.com (Sanchayan Maity)
Date: Mon,  3 Oct 2016 18:20:37 +0530
Subject: [PATCH v1 1/2] ARM: dts: vfxxx: Enable DMA for DSPI on Vybrid
Message-ID: <63fc108e2df00d2297a9b7014955f203bc802f34.1475498805.git.maitysanchayan@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable DMA for DSPI on Vybrid.

Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
---
 arch/arm/boot/dts/vf-colibri.dtsi | 4 ++++
 arch/arm/boot/dts/vfxxx.dtsi      | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/vf-colibri.dtsi b/arch/arm/boot/dts/vf-colibri.dtsi
index b741709..21bfef9 100644
--- a/arch/arm/boot/dts/vf-colibri.dtsi
+++ b/arch/arm/boot/dts/vf-colibri.dtsi
@@ -108,6 +108,10 @@
 	status = "okay";
 };
 
+&edma1 {
+	status = "okay";
+};
+
 &esdhc1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_esdhc1>;
diff --git a/arch/arm/boot/dts/vfxxx.dtsi b/arch/arm/boot/dts/vfxxx.dtsi
index 2c13ec6..eac4213 100644
--- a/arch/arm/boot/dts/vfxxx.dtsi
+++ b/arch/arm/boot/dts/vfxxx.dtsi
@@ -194,6 +194,9 @@
 				clocks = <&clks VF610_CLK_DSPI0>;
 				clock-names = "dspi";
 				spi-num-chipselects = <6>;
+				dmas = <&edma1 1 12>,
+					<&edma1 1 13>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
@@ -206,6 +209,9 @@
 				clocks = <&clks VF610_CLK_DSPI1>;
 				clock-names = "dspi";
 				spi-num-chipselects = <4>;
+				dmas = <&edma1 1 14>,
+					<&edma1 1 15>;
+				dma-names = "rx", "tx";
 				status = "disabled";
 			};
 
-- 
2.10.0
