From: nm@ti.com (Nishanth Menon)
Date: Mon, 29 Jul 2013 12:03:03 -0500
Subject: [PATCH V2 3/3] ARM: dts: omap5-uevm: update optional/unused regulator
 configurations
In-Reply-To: <1375117383-19285-1-git-send-email-nm@ti.com>
References: <51F67D7D.9070003@ti.com>
 <1375117383-19285-1-git-send-email-nm@ti.com>
Message-ID: <1375117383-19285-4-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

commit e00c27ef3b4c23e39d0a77b7c8e5be44c28001c7
(ARM: dts: OMAP5: Add Palmas MFD node and regulator nodes)
introduced regulator entries for OMAP5uEVM.

However, The regulator information is based on an older temporary
pre-production board variant and does not reflect production board
750-2628-XXX boards.

The following optional/unused regulators can be updated:

- SMPS9 supplies TWL6040 over VDDA_2v1_AUD. This regulator needs to be
enabled only when audio is active. Since it does not come active by
default, it does not require "always-on" or "boot-on".

- LDO2 and LDO8 do not go to any peripheral or connector on the board.
Further, these unused regulators should have been 2.8V for LDO2 and
3.0V for LDO8. Mark these LDOs as disabled in the dts until needed.

Reported-by: Marc J?ttner <m-juettner@ti.com>
Signed-off-by: Nishanth Menon <nm@ti.com>
Acked-by: J Keerthy <j-keerthy@ti.com>
---

V2: squash of multiple patches from V1, as suggested in:
	http://marc.info/?l=devicetree&m=137510852731656&w=2

 arch/arm/boot/dts/omap5-uevm.dts |   17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/arch/arm/boot/dts/omap5-uevm.dts b/arch/arm/boot/dts/omap5-uevm.dts
index 247c03c..65d7b60 100644
--- a/arch/arm/boot/dts/omap5-uevm.dts
+++ b/arch/arm/boot/dts/omap5-uevm.dts
@@ -331,8 +331,6 @@
 					regulator-name = "smps9";
 					regulator-min-microvolt = <2100000>;
 					regulator-max-microvolt = <2100000>;
-					regulator-always-on;
-					regulator-boot-on;
 					ti,smps-range = <0x80>;
 				};
 
@@ -355,10 +353,10 @@
 				ldo2_reg: ldo2 {
 					/* VCC_2V8_DISP: Does not go anywhere */
 					regulator-name = "ldo2";
-					regulator-min-microvolt = <2900000>;
-					regulator-max-microvolt = <2900000>;
-					regulator-always-on;
-					regulator-boot-on;
+					regulator-min-microvolt = <2800000>;
+					regulator-max-microvolt = <2800000>;
+					/* Unused */
+					status = "disabled";
 				};
 
 				ldo3_reg: ldo3 {
@@ -408,10 +406,11 @@
 				ldo8_reg: ldo8 {
 					/* VDD_3v0: Does not go anywhere */
 					regulator-name = "ldo8";
-					regulator-min-microvolt = <1500000>;
-					regulator-max-microvolt = <1500000>;
-					regulator-always-on;
+					regulator-min-microvolt = <3000000>;
+					regulator-max-microvolt = <3000000>;
 					regulator-boot-on;
+					/* Unused */
+					status = "disabled";
 				};
 
 				ldo9_reg: ldo9 {
-- 
1.7.9.5
