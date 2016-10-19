From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Wed, 19 Oct 2016 15:18:42 -0500
Subject: [PATCH 1/3] ARM: dts: socfpga: Add QSPI node for the Arria10
Message-ID: <1476908324-12313-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Add the QSPI device node for Arria10 SOC.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi |   14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 1149216..551c636 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -675,6 +675,20 @@
 			};
 		};
 
+		qspi: spi at ff809000 {
+			compatible = "cdns,qspi-nor";
+			#address-cells = <1>;
+			#size-cells = <0>;
+			reg = <0xff809000 0x100>,
+			      <0xffa00000 0x100000>;
+			interrupts = <0 100 IRQ_TYPE_LEVEL_HIGH>;
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
1.7.9.5
