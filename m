From: atull@opensource.altera.com (atull at opensource.altera.com)
Date: Tue, 13 Oct 2015 13:28:20 -0500
Subject: [PATCH] ARM: socfpga: dts: add fpga manager
Message-ID: <1444760900-1373-1-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alan Tull <atull@opensource.altera.com>

Add FPGA manager to device tree for SoCFPGA.

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index 314e589..e37ba11 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -834,5 +834,12 @@
 			compatible = "altr,sys-mgr", "syscon";
 			reg = <0xffd08000 0x4000>;
 		};
+
+		hps_0_fpgamgr: fpgamgr at 0xff706000 {
+			compatible = "altr,socfpga-fpga-mgr";
+			reg = <0xFF706000 0x1000
+			       0xFFB90000 0x1000>;
+			interrupts = <0 175 4>;
+		};
 	};
 };
-- 
1.9.1
