From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Wed, 1 Nov 2017 11:40:14 +0800
Subject: [PATCH 1/2] arm64: dts: ls1088a: add DT nodes for DSPI support
In-Reply-To: <20171101034015.41114-1-Zhiqiang.Hou@nxp.com>
References: <20171101034015.41114-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20171101034015.41114-2-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>

Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts | 28 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi    | 13 +++++++++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
index 30128051d0c0..cf5b85b93ae6 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a-qds.dts
@@ -134,6 +134,34 @@
 	};
 };
 
+&dspi {
+	status = "okay";
+
+	dflash0: n25q128a {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q128a11", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <3000000>;
+	};
+
+	dflash1: sst25wf040b {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "sst,sst25wf040b", "jedec,spi-nor";
+		reg = <1>;
+		spi-max-frequency = <3000000>;
+	};
+
+	dflash2: en25s64 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "eon,en25s64", "jedec,spi-nor";
+		reg = <2>;
+		spi-max-frequency = <3000000>;
+	};
+};
+
 &duart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index bd80e9a2e67c..f5ed3878abb7 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -276,6 +276,19 @@
 			};
 		};
 
+		dspi: dspi at 2100000 {
+			compatible = "fsl,ls1088a-dspi", "fsl,ls2085a-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2100000 0x0 0x10000>;
+			interrupts = <0 26 0x4>; /* Level high type */
+			clocks = <&clockgen 4 3>;
+			clock-names = "dspi";
+			spi-num-chipselects = <5>;
+			bus-num = <0>;
+			status = "disabled";
+		};
+
 		duart0: serial at 21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x0 0x21c0500 0x0 0x100>;
-- 
2.14.1
