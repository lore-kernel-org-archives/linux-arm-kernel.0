From: pantelis.antoniou@konsulko.com (Pantelis Antoniou)
Date: Wed, 13 May 2015 11:04:52 +0300
Subject: [PATCH] arm: dts: Enable beaglebone cape-manager
Message-ID: <1431504292-32132-1-git-send-email-pantelis.antoniou@konsulko.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the cape manager on the beaglebone family of boards.

Signed-off-by: Pantelis Antoniou <pantelis.antoniou@konsulko.com>
---
 arch/arm/boot/dts/am335x-bone-common.dtsi | 42 +++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone-common.dtsi b/arch/arm/boot/dts/am335x-bone-common.dtsi
index 236b7db..28d9764 100644
--- a/arch/arm/boot/dts/am335x-bone-common.dtsi
+++ b/arch/arm/boot/dts/am335x-bone-common.dtsi
@@ -375,3 +375,45 @@
 &sham {
 	status = "okay";
 };
+
+/* the cape manager */
+/ {
+	bone_capemgr {
+		compatible = "ti,bone-capemgr";
+		status = "okay";
+
+		eeprom = <&baseboard_data>;
+
+		/* map board revisions to compatible definitions */
+		baseboardmaps {
+			baseboard_beaglebone: board at 0 {
+				board-name = "A335BONE";
+				compatible-name = "ti,beaglebone";
+			};
+
+			baseboard_beaglebone_black: board at 1 {
+				board-name = "A335BNLT";
+				compatible-name = "ti,beaglebone-black";
+			};
+		};
+
+		/* only 4 slots defined */
+		slots {
+			slot at 0 {
+				eeprom = <&cape0_data>;
+			};
+
+			slot at 1 {
+				eeprom = <&cape1_data>;
+			};
+
+			slot at 2 {
+				eeprom = <&cape2_data>;
+			};
+
+			slot at 3 {
+				eeprom = <&cape3_data>;
+			};
+		};
+	};
+};
-- 
1.7.12
