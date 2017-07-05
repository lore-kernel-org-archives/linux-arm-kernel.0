From: alex@asyring.de (Alexander Syring)
Date: Wed,  5 Jul 2017 10:30:20 +0200
Subject: [PATCH] ARM: sun7i: dts: enable battery power supply subnode on
 cubietruck
Message-ID: <20170705083020.14865-1-alex@asyring.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Cubietruck has an AXP209 PMIC with battery connector.

This enables the battery power supply subnode.

Signed-off-by: Alexander Syring <alex@asyring.de>
---
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 102903e83bd2..13bbf2361f9c 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -271,6 +271,10 @@
 	status = "okay";
 };
 
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
-- 
2.11.0
