From: marex@denx.de (Marek Vasut)
Date: Thu,  4 Oct 2018 00:54:18 +0200
Subject: [PATCH] ARM: dts: socfpga: Turn FPGA manager node into syscon
Message-ID: <20181003225418.21742-1-marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The FPGA manager contains additional functionality, the GPI/GPO block.
Turn the FPGA manager node into syscon, so that the gpio-syscon driver
can be used to access the GPI/GPO block.

Signed-off-by: Marek Vasut <marex@denx.de>
---
 arch/arm/boot/dts/socfpga.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
index daf249e57b08..1835a824c9b9 100644
--- a/arch/arm/boot/dts/socfpga.dtsi
+++ b/arch/arm/boot/dts/socfpga.dtsi
@@ -551,7 +551,7 @@
 		};
 
 		fpgamgr0: fpgamgr at ff706000 {
-			compatible = "altr,socfpga-fpga-mgr";
+			compatible = "altr,socfpga-fpga-mgr", "syscon";
 			reg = <0xff706000 0x1000
 			       0xffb90000 0x4>;
 			interrupts = <0 175 4>;
-- 
2.18.0
