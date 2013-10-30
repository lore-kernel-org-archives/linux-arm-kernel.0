From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 30 Oct 2013 09:38:10 -0700
Subject: [PATCH v2 2/2] arm: dt: zynq: Add SDHCI nodes
In-Reply-To: <1383151090-13885-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1383151090-13885-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1383151090-13885-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add nodes for the Arasan SDHCI controller to Zynq dts files.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
v2:
 - update compatibilty string according to changes in 1/2 (append
   '-8.9a' IP version string)
---
 arch/arm/boot/dts/zynq-7000.dtsi | 20 ++++++++++++++++++++
 arch/arm/boot/dts/zynq-zc702.dts |  4 ++++
 arch/arm/boot/dts/zynq-zc706.dts |  4 ++++
 arch/arm/boot/dts/zynq-zed.dts   |  4 ++++
 4 files changed, 32 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index e32b92b949d2..931f230306cb 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -65,6 +65,26 @@
 			interrupts = <0 50 4>;
 		};
 
+		sdhci0: ps7-sdhci at e0100000 {
+			compatible = "arasan,sdhci-8.9a";
+			status = "disabled";
+			clock-names = "clk_xin", "clk_ahb";
+			clocks = <&clkc 21>, <&clkc 32>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 24 4>;
+			reg = <0xe0100000 0x1000>;
+		} ;
+
+		sdhci1: ps7-sdhci at e0101000 {
+			compatible = "arasan,sdhci-8.9a";
+			status = "disabled";
+			clock-names = "clk_xin", "clk_ahb";
+			clocks = <&clkc 22>, <&clkc 33>;
+			interrupt-parent = <&intc>;
+			interrupts = <0 47 4>;
+			reg = <0xe0101000 0x1000>;
+		} ;
+
 		slcr: slcr at f8000000 {
 			compatible = "xlnx,zynq-slcr";
 			reg = <0xF8000000 0x1000>;
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index 21aea99a067b..454394453e9c 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -29,6 +29,10 @@
 
 };
 
+&sdhci0 {
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/zynq-zc706.dts b/arch/arm/boot/dts/zynq-zc706.dts
index 79009e0b74b9..d734d5411760 100644
--- a/arch/arm/boot/dts/zynq-zc706.dts
+++ b/arch/arm/boot/dts/zynq-zc706.dts
@@ -30,6 +30,10 @@
 
 };
 
+&sdhci0 {
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 };
diff --git a/arch/arm/boot/dts/zynq-zed.dts b/arch/arm/boot/dts/zynq-zed.dts
index d6acf2b1cdf4..cd259dd13cdc 100644
--- a/arch/arm/boot/dts/zynq-zed.dts
+++ b/arch/arm/boot/dts/zynq-zed.dts
@@ -30,6 +30,10 @@
 
 };
 
+&sdhci0 {
+	status = "okay";
+};
+
 &uart1 {
 	status = "okay";
 };
-- 
1.8.4.1
