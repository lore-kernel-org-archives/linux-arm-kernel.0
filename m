From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 10 Mar 2016 22:38:02 +0100
Subject: [PATCH 1/3] ARM: dts: sun5i-a13-inet98v-rev2: Remove mmc2 node
Message-ID: <1457645884-10282-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The sun5i-a13-inet98v-rev2 does not have an emmc, it uses nand, the
mmc2 node in the dts comes from a copy and paste error from the
utoo-p66 dts, remove it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts b/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts
index 6fa54b6..1b11ec9 100644
--- a/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts
+++ b/arch/arm/boot/dts/sun5i-a13-inet-98v-rev2.dts
@@ -123,21 +123,6 @@
 	status = "okay";
 };
 
-&mmc2 {
-	pinctrl-names = "default";
-	pinctrl-0 = <&mmc2_pins_a>;
-	vmmc-supply = <&reg_vcc3v3>;
-	bus-width = <8>;
-	non-removable;
-	status = "okay";
-
-	mmccard: mmccard at 0 {
-		reg = <0>;
-		compatible = "mmc-card";
-		broken-hpi;
-	};
-};
-
 &otg_sram {
 	status = "okay";
 };
-- 
2.7.2
