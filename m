From: vbridger@opensource.altera.com (Vince Bridgers)
Date: Mon, 20 Apr 2015 11:24:28 -0500
Subject: [PATCH 2/2] ARM: socfpga: dts: Add tx-fifo-depth and rx-fifo-depth
 properties
In-Reply-To: <1429547068-12501-1-git-send-email-vbridger@opensource.altera.com>
References: <1429547068-12501-1-git-send-email-vbridger@opensource.altera.com>
Message-ID: <1429547068-12501-2-git-send-email-vbridger@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add tx-fifo-depth and rx-fifo-depth devicetree properties for socfpga
stmmac. These devicetree properties will be used to configure certain
features of the stmmac on the socfpga.

Signed-off-by: Vince Bridgers <vbridger@opensource.altera.com>
---
This patch is based on patches
http://www.spinics.net/lists/devicetree/msg75270.html
http://www.spinics.net/lists/devicetree/msg75273.html
---
 arch/arm/boot/dts/socfpga.dtsi         | 4 ++++
 arch/arm/boot/dts/socfpga_arria10.dtsi | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index d9176e6..4721a9d 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -488,6 +488,8 @@
 			reset-names = "stmmaceth";
 			snps,multicast-filter-bins = <256>;
 			snps,perfect-filter-entries = <128>;
+			tx-fifo-depth = <4096>;
+			rx-fifo-depth = <4096>;
 			status = "disabled";
 		};
 
@@ -504,6 +506,8 @@
 			reset-names = "stmmaceth";
 			snps,multicast-filter-bins = <256>;
 			snps,perfect-filter-entries = <128>;
+			tx-fifo-depth = <4096>;
+			rx-fifo-depth = <4096>;
 			status = "disabled";
 		};
 
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index d2ef52b..9c6dcff 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -397,6 +397,8 @@
 			mac-address = [00 00 00 00 00 00];
 			snps,multicast-filter-bins = <256>;
 			snps,perfect-filter-entries = <128>;
+			tx-fifo-depth = <4096>;
+			rx-fifo-depth = <16384>;
 			clocks = <&l4_mp_clk>;
 			clock-names = "stmmaceth";
 			status = "disabled";
@@ -412,6 +414,8 @@
 			mac-address = [00 00 00 00 00 00];
 			snps,multicast-filter-bins = <256>;
 			snps,perfect-filter-entries = <128>;
+			tx-fifo-depth = <4096>;
+			rx-fifo-depth = <16384>;
 			status = "disabled";
 		};
 
@@ -425,6 +429,8 @@
 			mac-address = [00 00 00 00 00 00];
 			snps,multicast-filter-bins = <256>;
 			snps,perfect-filter-entries = <128>;
+			tx-fifo-depth = <4096>;
+			rx-fifo-depth = <16384>;
 			status = "disabled";
 		};
 
-- 
1.9.1
