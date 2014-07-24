From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 25 Jul 2014 01:00:14 +0200
Subject: [PATCH v2 05/11] ARM: dts: zynq: Add QSPI for Parallella
In-Reply-To: <1406242820-20140-1-git-send-email-afaerber@suse.de>
References: <1406242820-20140-1-git-send-email-afaerber@suse.de>
Message-ID: <1406242820-20140-6-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Prepare SPI0 and SPI1 while at it.

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v2: New
 
 arch/arm/boot/dts/zynq-7000.dtsi      | 37 +++++++++++++++++++++++++++++++++++
 arch/arm/boot/dts/zynq-parallella.dts |  4 ++++
 2 files changed, 41 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 8fd826a..eed3df0 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -122,6 +122,30 @@
 			interrupts = <0 50 4>;
 		};
 
+		spi0: spi at e0006000 {
+			compatible = "xlnx,zynq-spi-r1p6";
+			reg = <0xe0006000 0x1000>;
+			status = "disabled";
+			interrupt-parent = <&intc>;
+			interrupts = <0 26 4>;
+			clocks = <&clkc 25>, <&clkc 34>;
+			clock-names = "ref_clk", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
+		spi1: spi at e0007000 {
+			compatible = "xlnx,zynq-spi-r1p6";
+			reg = <0xe0007000 0x1000>;
+			status = "disabled";
+			interrupt-parent = <&intc>;
+			interrupts = <0 49 4>;
+			clocks = <&clkc 26>, <&clkc 35>;
+			clock-names = "ref_clk", "pclk";
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		gem0: ethernet at e000b000 {
 			compatible = "cdns,gem";
 			reg = <0xe000b000 0x4000>;
@@ -140,6 +164,19 @@
 			clock-names = "pclk", "hclk", "tx_clk";
 		};
 
+		qspi: qspi at e000d000 {
+			compatible = "xlnx,zynq-spi-r1p6";
+			reg = <0xe000d000 0x1000>;
+			status = "disabled";
+			interrupt-parent = <&intc>;
+			interrupts = <0 19 4>;
+			clocks = <&clkc 10>, <&clkc 43>;
+			clock-names = "ref_clk", "pclk";
+			num-cs = <1>;
+			#address-cells = <1>;
+			#size-cells = <0>;
+		};
+
 		sdhci0: sdhci at e0100000 {
 			compatible = "arasan,sdhci-8.9a";
 			status = "disabled";
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 41afd9d..56f68ea 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -55,6 +55,10 @@
 	status = "okay";
 };
 
+&qspi {
+	status = "okay";
+};
+
 &sdhci1 {
 	status = "okay";
 };
-- 
1.9.3
