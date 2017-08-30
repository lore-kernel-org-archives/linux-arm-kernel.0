From: Zhiqiang.Hou@nxp.com (Zhiqiang Hou)
Date: Wed, 30 Aug 2017 18:12:36 +0800
Subject: [PATCHv2 1/3] arm64: dts: ls1012a: add the DTS node for DSPI support
In-Reply-To: <20170830101238.28378-1-Zhiqiang.Hou@nxp.com>
References: <20170830101238.28378-1-Zhiqiang.Hou@nxp.com>
Message-ID: <20170830101238.28378-2-Zhiqiang.Hou@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
Signed-off-by: Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
---
V2:
 - No change

 arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts | 33 +++++++++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi    | 13 +++++++++
 2 files changed, 46 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
index 8c013b54db14..cdc4aee75227 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a-qds.dts
@@ -93,6 +93,39 @@
 	};
 };
 
+&dspi {
+	bus-num = <0>;
+	status = "okay";
+
+	flash at 0 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "n25q128a11", "jedec,spi-nor";
+		reg = <0>;
+		spi-max-frequency = <10000000>;
+	};
+
+	flash at 1 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "sst25wf040b", "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <1>;
+		spi-max-frequency = <10000000>;
+	};
+
+	flash at 2 {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		compatible = "en25s64", "jedec,spi-nor";
+		spi-cpol;
+		spi-cpha;
+		reg = <2>;
+		spi-max-frequency = <10000000>;
+	};
+};
+
 &duart0 {
 	status = "okay";
 };
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
index df83915d6ea6..09ce00022728 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1012a.dtsi
@@ -355,6 +355,19 @@
 			status = "disabled";
 		};
 
+		dspi: dspi at 2100000 {
+			compatible = "fsl,ls1012a-dspi", "fsl,ls1021a-v1.0-dspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x2100000 0x0 0x10000>;
+			interrupts = <0 64 IRQ_TYPE_LEVEL_HIGH>;
+			clock-names = "dspi";
+			clocks = <&clockgen 4 0>;
+			spi-num-chipselects = <5>;
+			big-endian;
+			status = "disabled";
+		};
+
 		duart0: serial at 21c0500 {
 			compatible = "fsl,ns16550", "ns16550a";
 			reg = <0x00 0x21c0500 0x0 0x100>;
-- 
2.14.1
