From: mpa@pengutronix.de (Markus Pargmann)
Date: Wed, 18 Dec 2013 17:47:22 +0100
Subject: [PATCH 6/6] arm: dts: am335x beagle bone use processor macids
In-Reply-To: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
References: <1387385242-1161-1-git-send-email-mpa@pengutronix.de>
Message-ID: <1387385242-1161-7-git-send-email-mpa@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Use macids stored in the am335x chip.

Signed-off-by: Markus Pargmann <mpa@pengutronix.de>
---
 arch/arm/boot/dts/am335x-bone.dts      | 8 ++++++++
 arch/arm/boot/dts/am335x-boneblack.dts | 8 ++++++++
 2 files changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/am335x-bone.dts b/arch/arm/boot/dts/am335x-bone.dts
index 94ee427..9b65a62 100644
--- a/arch/arm/boot/dts/am335x-bone.dts
+++ b/arch/arm/boot/dts/am335x-bone.dts
@@ -10,6 +10,14 @@
 #include "am33xx.dtsi"
 #include "am335x-bone-common.dtsi"
 
+&cpsw_emac0 {
+	ti,mac-address-ctrl = <&cpsw_ctrl_macid 0>;
+};
+
+&cpsw_emac1 {
+	ti,mac-address-ctrl = <&cpsw_ctrl_macid 1>;
+};
+
 &ldo3_reg {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <3300000>;
diff --git a/arch/arm/boot/dts/am335x-boneblack.dts b/arch/arm/boot/dts/am335x-boneblack.dts
index 6b71ad9..f6f0b40 100644
--- a/arch/arm/boot/dts/am335x-boneblack.dts
+++ b/arch/arm/boot/dts/am335x-boneblack.dts
@@ -10,6 +10,14 @@
 #include "am33xx.dtsi"
 #include "am335x-bone-common.dtsi"
 
+&cpsw_emac0 {
+	ti,mac-address-ctrl = <&cpsw_ctrl_macid 0>;
+};
+
+&cpsw_emac1 {
+	ti,mac-address-ctrl = <&cpsw_ctrl_macid 1>;
+};
+
 &ldo3_reg {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-- 
1.8.5.1
