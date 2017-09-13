From: icenowy@aosc.io (Icenowy Zheng)
Date: Wed, 13 Sep 2017 21:21:30 +0800
Subject: [PATCH] ARM: sun7i: a20: enable ac/battery power supplies for Lamobo
 R1 board
Message-ID: <20170913132130.56551-1-icenowy@aosc.io>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Lamobo R1 board connected the ACIN of the AXP209 PMIC to a MicroUSB
port, and the battery input is connected to a generic connector.

Enable these two power supplies in the device tree.

Signed-off-by: Icenowy Zheng <icenowy@aosc.io>
---
 arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
index 004b6ddac813..6ab2a6649eb1 100644
--- a/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
+++ b/arch/arm/boot/dts/sun7i-a20-lamobo-r1.dts
@@ -241,6 +241,14 @@
 
 #include "axp209.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_ahci_5v {
 	gpio = <&pio 1 3 GPIO_ACTIVE_HIGH>; /* PB3 */
 	status = "okay";
-- 
2.13.5
