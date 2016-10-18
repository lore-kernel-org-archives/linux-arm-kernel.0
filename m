From: s.trumtrar@pengutronix.de (Steffen Trumtrar)
Date: Tue, 18 Oct 2016 09:43:02 +0200
Subject: [PATCH 1/3] ARM: socfpga: dtsi: add qspi node
Message-ID: <20161018074304.6744-1-s.trumtrar@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the qspi node to the socfpga dtsi file.

Signed-off-by: Steffen Trumtrar <s.trumtrar@pengutronix.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 9f48141270b8..0dc96d2248a6 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -705,6 +705,20 @@
 			reg = <0xffff0000 0x10000>;
 		};
 
+		qspi: spi at ff705000 {
+			compatible = "cdns,qspi-nor";
+                        #address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xff705000 0x1000>,
+			      <0xffa00000 0x1000>;
+			interrupts = <0 151 4>;
+			cdns,fifo-depth = <128>;
+			cdns,fifo-width = <4>;
+			cdns,trigger-address = <0x00000000>;
+			clocks = <&qspi_clk>;
+			status = "disabled";
+		};
+
 		rst: rstmgr at ffd05000 {
 			#reset-cells = <1>;
 			compatible = "altr,rst-mgr";
-- 
2.9.3
