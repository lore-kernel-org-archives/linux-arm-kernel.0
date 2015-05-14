From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 14 May 2015 10:00:43 -0500
Subject: [PATCH] ARM: socfpga: dts: add the a9-scu node for arria10
Message-ID: <1431615643-4668-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Add a dts node for the A9 SCU on the Arria10 platform.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index abf9763..d025f77 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -567,6 +567,11 @@
 			reg = <0xffd05000 0x100>;
 		};
 
+		scu: snoop-control-unit at ffffc000 {
+			compatible = "arm,cortex-a9-scu";
+			reg = <0xffffc000 0x100>;
+		};
+
 		sysmgr: sysmgr at ffd06000 {
 			compatible = "altr,sys-mgr", "syscon";
 			reg = <0xffd06000 0x300>;
-- 
2.2.1
