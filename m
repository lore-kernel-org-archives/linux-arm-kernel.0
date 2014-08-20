From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 20 Aug 2014 08:56:58 -0700
Subject: [PATCH 2/3] ARM: zynq: DT: Move size/address properties to dtsi
In-Reply-To: <1408550219-19825-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1408550219-19825-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1408550219-19825-2-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Move the GEM's size and address cells properties to the common
dtsi file.

Cc: Andreas F?rber <afaerber@suse.de>
Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi      | 4 ++++
 arch/arm/boot/dts/zynq-parallella.dts | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 6cc83d4c6c76..4e6e96ef7bd0 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -195,6 +195,8 @@
 			interrupts = <0 22 4>;
 			clocks = <&clkc 30>, <&clkc 30>, <&clkc 13>;
 			clock-names = "pclk", "hclk", "tx_clk";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		gem1: ethernet at e000c000 {
@@ -204,6 +206,8 @@
 			interrupts = <0 45 4>;
 			clocks = <&clkc 31>, <&clkc 31>, <&clkc 14>;
 			clock-names = "pclk", "hclk", "tx_clk";
+			#address-cells = <1>;
+			#size-cells = <0>;
 		};
 
 		sdhci0: sdhci at e0100000 {
diff --git a/arch/arm/boot/dts/zynq-parallella.dts b/arch/arm/boot/dts/zynq-parallella.dts
index 41afd9da6876..690e6206beac 100644
--- a/arch/arm/boot/dts/zynq-parallella.dts
+++ b/arch/arm/boot/dts/zynq-parallella.dts
@@ -38,8 +38,6 @@
 	status = "okay";
 	phy-mode = "rgmii-id";
 	phy-handle = <&ethernet_phy>;
-	#address-cells = <1>;
-	#size-cells = <0>;
 
 	ethernet_phy: ethernet-phy at 0 {
 		/* Marvell 88E1318 */
-- 
2.0.1.1.gfbfc394
