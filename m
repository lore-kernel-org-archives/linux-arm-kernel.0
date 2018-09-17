From: Anson.Huang@nxp.com (Anson Huang)
Date: Mon, 17 Sep 2018 11:17:43 +0800
Subject: [PATCH V2 1/2] ARM: dts: imx6ul: use nvmem-cells for cpu speed grading
Message-ID: <1537154264-23252-1-git-send-email-Anson.Huang@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On i.MX6UL, accessing OCOTP directly is wrong because the ocotp clock
needs to be enabled first, so use the nvmem-cells binding instead.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
no change since V1.
 arch/arm/boot/dts/imx6ul.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/imx6ul.dtsi b/arch/arm/boot/dts/imx6ul.dtsi
index 5ef4320..ff8c6de 100644
--- a/arch/arm/boot/dts/imx6ul.dtsi
+++ b/arch/arm/boot/dts/imx6ul.dtsi
@@ -89,6 +89,8 @@
 				      "pll1_sys";
 			arm-supply = <&reg_arm>;
 			soc-supply = <&reg_soc>;
+			nvmem-cells = <&cpu_speed_grade>;
+			nvmem-cell-names = "speed_grade";
 		};
 	};
 
@@ -943,6 +945,10 @@
 				tempmon_temp_grade: temp-grade at 20 {
 					reg = <0x20 4>;
 				};
+
+				cpu_speed_grade: speed-grade at 10 {
+					reg = <0x10 4>;
+				};
 			};
 
 			lcdif: lcdif at 21c8000 {
-- 
2.7.4
