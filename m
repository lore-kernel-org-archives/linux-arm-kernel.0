From: yao.yuan@freescale.com (Yuan Yao)
Date: Thu, 31 Mar 2016 14:45:01 +0800
Subject: [PATCH 2/2] dts/ls1043a: add the DTS node for QSPI support
In-Reply-To: <1459406701-40993-1-git-send-email-yao.yuan@freescale.com>
References: <1459406701-40993-1-git-send-email-yao.yuan@freescale.com>
Message-ID: <1459406701-40993-3-git-send-email-yao.yuan@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Yuan Yao <yao.yuan@nxp.com>

Signed-off-by: Yuan Yao <yao.yuan@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts | 16 ++++++++++++++++
 arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi    | 14 ++++++++++++++
 2 files changed, 30 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
index 97e9906..c8303a3 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a-qds.dts
@@ -100,6 +100,22 @@
 	};
 };
 
+&qspi {
+	num-cs = <2>;
+	bus-num = <0>;
+	status = "okay";
+	fsl,ddr-sampling-point = <4>;
+
+	qflash0: s25fl128s at 0 {
+		compatible = "spansion,m25p80";
+		#address-cells = <1>;
+		#size-cells = <1>;
+		spi-max-frequency = <20000000>;
+		ddr-quad-read;
+		reg = <0>;
+	};
+};
+
 &i2c0 {
 	status = "okay";
 	pca9547 at 77 {
diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
index be72bf5..49b1aeb 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1043a.dtsi
@@ -208,6 +208,20 @@
 			status = "disabled";
 		};
 
+		qspi: quadspi at 1550000 {
+			compatible = "fsl,ls1043a-qspi", "fsl,ls1021a-qspi";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0x0 0x1550000 0x0 0x10000>,
+				<0x0 0x40000000 0x0 0x4000000>;
+			reg-names = "QuadSPI", "QuadSPI-memory";
+			interrupts = <0 99 0x4>;
+			clock-names = "qspi_en", "qspi";
+			clocks = <&clockgen 4 0>, <&clockgen 4 0>;
+			big-endian;
+			status = "disabled";
+		};
+
 		i2c0: i2c at 2180000 {
 			compatible = "fsl,vf610-i2c";
 			#address-cells = <1>;
-- 
2.1.0.27.g96db324
