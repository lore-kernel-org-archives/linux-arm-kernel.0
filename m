From: horia.geanta@nxp.com (=?UTF-8?q?Horia=20Geant=C4=83?=)
Date: Tue, 18 Jul 2017 18:30:50 +0300
Subject: [PATCH 4/4] arm64: dts: freescale: ls1088a: add crypto node
In-Reply-To: <20170718153050.15330-1-horia.geanta@nxp.com>
References: <20170718153050.15330-1-horia.geanta@nxp.com>
Message-ID: <20170718153050.15330-5-horia.geanta@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

LS1088A has a SEC v5.3 security engine.

Signed-off-by: Horia Geant? <horia.geanta@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 43 ++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index c144d06a6e33..6c22d75bc504 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -52,6 +52,10 @@
 	#address-cells = <2>;
 	#size-cells = <2>;
 
+	aliases {
+		crypto = &crypto;
+	};
+
 	cpus {
 		#address-cells = <1>;
 		#size-cells = <0>;
@@ -369,6 +373,45 @@
 			dma-coherent;
 			status = "disabled";
 		};
+
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
 	};
 
 };
-- 
2.12.0.264.gd6db3f216544
