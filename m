From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Thu, 13 Jun 2013 09:37:16 -0700
Subject: [PATCH v3 2/4] arm: dt: zynq: Use 'status' property for UART nodes
In-Reply-To: <1371141438-16553-1-git-send-email-soren.brinkmann@xilinx.com>
References: <1371141438-16553-1-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <1371141438-16553-3-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Set the default status for UARTs to disabled in the zynq-7000.dtsi file
and let board dts files enable the UARTs on demand.

Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
---
 arch/arm/boot/dts/zynq-7000.dtsi | 2 ++
 arch/arm/boot/dts/zynq-zc702.dts | 6 +++++-
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index 0dbee2c..6f54a64 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -49,6 +49,7 @@
 
 		uart0: uart at e0000000 {
 			compatible = "xlnx,xuartps";
+			status = "disabled";
 			clocks = <&clkc 23>, <&clkc 40>;
 			clock-names = "ref_clk", "aper_clk";
 			reg = <0xE0000000 0x1000>;
@@ -57,6 +58,7 @@
 
 		uart1: uart at e0001000 {
 			compatible = "xlnx,xuartps";
+			status = "disabled";
 			clocks = <&clkc 24>, <&clkc 41>;
 			clock-names = "ref_clk", "aper_clk";
 			reg = <0xE0001000 0x1000>;
diff --git a/arch/arm/boot/dts/zynq-zc702.dts b/arch/arm/boot/dts/zynq-zc702.dts
index e25a307..21aea99 100644
--- a/arch/arm/boot/dts/zynq-zc702.dts
+++ b/arch/arm/boot/dts/zynq-zc702.dts
@@ -24,7 +24,11 @@
 	};
 
 	chosen {
-		bootargs = "console=ttyPS1,115200 earlyprintk";
+		bootargs = "console=ttyPS0,115200 earlyprintk";
 	};
 
 };
+
+&uart1 {
+	status = "okay";
+};
-- 
1.8.3
