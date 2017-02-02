From: thor.thayer@linux.intel.com (thor.thayer at linux.intel.com)
Date: Thu,  2 Feb 2017 16:05:21 -0600
Subject: [PATCHv2] ARM: dts: Add EMAC AXI settings for Arria10
Message-ID: <1486073121-3364-1-git-send-email-thor.thayer@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <thor.thayer@linux.intel.com>

Add the device tree entries needed to support the EMAC AXI
bus settings on the Arria10 SoCFPGA chip.

Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
---
v2 Add the AXI configuration to the other DW EMACs in the chip.
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index f520cbf..9abc7d8 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -400,6 +400,12 @@
 				};
 		};
 
+		socfpga_axi_setup: stmmac-axi-config {
+			snps,wr_osr_lmt = <0xf>;
+			snps,rd_osr_lmt = <0xf>;
+			snps,blen = <0 0 0 0 16 0 0>;
+		};
+
 		gmac0: ethernet at ff800000 {
 			compatible = "altr,socfpga-stmmac", "snps,dwmac-3.72a", "snps,dwmac";
 			altr,sysmgr-syscon = <&sysmgr 0x44 0>;
@@ -416,6 +422,7 @@
 			clock-names = "stmmaceth";
 			resets = <&rst EMAC0_RESET>;
 			reset-names = "stmmaceth";
+			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
 
@@ -435,6 +442,7 @@
 			clock-names = "stmmaceth";
 			resets = <&rst EMAC1_RESET>;
 			reset-names = "stmmaceth";
+			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
 
@@ -452,6 +460,7 @@
 			rx-fifo-depth = <16384>;
 			clocks = <&l4_mp_clk>;
 			clock-names = "stmmaceth";
+			snps,axi-config = <&socfpga_axi_setup>;
 			status = "disabled";
 		};
 
-- 
2.7.4
