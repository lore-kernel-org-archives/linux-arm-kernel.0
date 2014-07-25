From: afaerber@suse.de (=?UTF-8?q?Andreas=20F=C3=A4rber?=)
Date: Fri, 25 Jul 2014 13:12:31 +0200
Subject: [PATCH v3] ARM: dts: zynq: Add SPI
In-Reply-To: <1cf9126b-c5e4-4ae7-a294-071584857d6c@BN1AFFO11FD052.protection.gbl>
References: <1cf9126b-c5e4-4ae7-a294-071584857d6c@BN1AFFO11FD052.protection.gbl>
Message-ID: <1406286752-8905-1-git-send-email-afaerber@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Andreas F?rber <afaerber@suse.de>
---
 v3: Split off from QSPI (Michal Simek).
 
 arch/arm/boot/dts/zynq-7000.dtsi | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm/boot/dts/zynq-7000.dtsi b/arch/arm/boot/dts/zynq-7000.dtsi
index cf0f3e4..ef11dab 100644
--- a/arch/arm/boot/dts/zynq-7000.dtsi
+++ b/arch/arm/boot/dts/zynq-7000.dtsi
@@ -140,6 +140,30 @@
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
-- 
1.9.3
