From: horia.geanta@nxp.com (=?UTF-8?q?Horia=20Geant=C4=83?=)
Date: Tue, 18 Jul 2017 18:30:49 +0300
Subject: [PATCH 3/4] arm64: dts: freescale: ls208xa: add crypto node
In-Reply-To: <20170718153050.15330-1-horia.geanta@nxp.com>
References: <20170718153050.15330-1-horia.geanta@nxp.com>
Message-ID: <20170718153050.15330-4-horia.geanta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LS208xA has a SEC v5.1 security engine.

Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi | 41 ++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
index f135b987d13b..fc1234dc90f9 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls208xa.dtsi
@@ -46,6 +46,7 @@
  */
 
 #include <dt-bindings/thermal/thermal.h>
+#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 / {
 	compatible = "fsl,ls2080a";
@@ -54,6 +55,7 @@
 	#size-cells = <2>;
 
 	aliases {
+		crypto = &crypto;
 		serial0 = &serial0;
 		serial1 = &serial1;
 	};
@@ -306,6 +308,45 @@
 			clock-names = "apb_pclk", "wdog_clk";
 		};
 
+		crypto: crypto at 8000000 {
+			compatible = "fsl,sec-v5.0", "fsl,sec-v4.0";
+			fsl,sec-era = <8>;
+			#address-cells = <1>;
+			#size-cells = <1>;
+			ranges = <0x0 0x00 0x8000000 0x100000>;
+			reg = <0x00 0x8000000 0x0 0x100000>;
+			interrupts = <GIC_SPI 139 IRQ_TYPE_LEVEL_HIGH>;
+			dma-coherent;
+
+			sec_jr0: jr at 10000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	   = <0x10000 0x10000>;
+				interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr1: jr at 20000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	   = <0x20000 0x10000>;
+				interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr2: jr at 30000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	   = <0x30000 0x10000>;
+				interrupts = <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
+			sec_jr3: jr at 40000 {
+				compatible = "fsl,sec-v5.0-job-ring",
+					     "fsl,sec-v4.0-job-ring";
+				reg	   = <0x40000 0x10000>;
+				interrupts = <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>;
+			};
+		};
+
 		fsl_mc: fsl-mc at 80c000000 {
 			compatible = "fsl,qoriq-mc";
 			reg = <0x00000008 0x0c000000 0 0x40>,	 /* MC portal base */
-- 
2.12.0.264.gd6db3f216544
