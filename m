From: tthayer@opensource.altera.com (tthayer at opensource.altera.com)
Date: Wed, 25 May 2016 11:29:43 -0500
Subject: [PATCH 5/5] ARM: dts: Move Arria10 SDRAM as child of ECC Manager
In-Reply-To: <1464193783-5071-1-git-send-email-tthayer@opensource.altera.com>
References: <1464193783-5071-1-git-send-email-tthayer@opensource.altera.com>
Message-ID: <1464193783-5071-6-git-send-email-tthayer@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Thor Thayer <tthayer@opensource.altera.com>

Changes to support ECC Manager as SDRAM IRQ parent by
1) updating IRQ property values to correct child IRQs
2) moving node under ECC Manager.

Signed-off-by: Thor Thayer <tthayer@opensource.altera.com>
---
 arch/arm/boot/dts/socfpga_arria10.dtsi |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/arm/boot/dts/socfpga_arria10.dtsi b/arch/arm/boot/dts/socfpga_arria10.dtsi
index 0901090..605c21e 100644
--- a/arch/arm/boot/dts/socfpga_arria10.dtsi
+++ b/arch/arm/boot/dts/socfpga_arria10.dtsi
@@ -568,12 +568,6 @@
 			reg = <0xffcfb100 0x80>;
 		};
 
-		sdramedac {
-			compatible = "altr,sdram-edac-a10";
-			altr,sdr-syscon = <&sdr>;
-			interrupts = <0 2 4>, <0 0 4>;
-		};
-
 		L2: l2-cache at fffff000 {
 			compatible = "arm,pl310-cache";
 			reg = <0xfffff000 0x1000>;
@@ -610,6 +604,13 @@
 			#interrupt-cells = <2>;
 			ranges;
 
+			sdramedac {
+				compatible = "altr,sdram-edac-a10";
+				altr,sdr-syscon = <&sdr>;
+				interrupts = <17 IRQ_TYPE_LEVEL_HIGH>,
+					     <49 IRQ_TYPE_LEVEL_HIGH>;
+			};
+
 			l2-ecc at ffd06010 {
 				compatible = "altr,socfpga-a10-l2-ecc";
 				reg = <0xffd06010 0x4>;
-- 
1.7.9.5
