From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Mon, 26 Sep 2016 14:34:59 -0500
Subject: [PATCH] ARM: dts: socfpga: enable arm,shared-override in the pl310
Message-ID: <1474918499-9811-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Enable the bit(22) shared-override bit for the SoCFPGA family. While at it,
enable the prefetch-data and prefetch-instr settings for the Arria10.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi         |    1 +
 arch/arm/boot/dts/socfpga_arria10.dtsi |    3 +++
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 9f48141..28ff6e4 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -686,6 +686,7 @@
 			arm,data-latency = <2 1 1>;
 			prefetch-data = <1>;
 			prefetch-instr = <1>;
+			arm,shared-override;
 		};
 
 		mmc: dwmmc0 at ff704000 {
diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 94000cb..16fcb9f 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -573,6 +573,9 @@
 			interrupts = <0 18 IRQ_TYPE_LEVEL_HIGH>;
 			cache-unified;
 			cache-level = <2>;
+			prefetch-data = <1>;
+			prefetch-instr = <1>;
+			arm,shared-override;
 		};
 
 		mmc: dwmmc0 at ff808000 {
-- 
1.7.9.5
