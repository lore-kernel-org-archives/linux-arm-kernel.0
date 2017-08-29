From: harald@ccbib.org (Harald Geyer)
Date: Tue, 29 Aug 2017 19:08:10 +0200
Subject: [PATCH] ARM: dts: sun7i: Enable power supplies on A20-OLinuxIno-Micro
Message-ID: <20170829170810.1302-1-harald@ccbib.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The axp209.dtsi defines nodes for ac, usb and battery supplies for a
while now. This patch enables these nodes for the A20-Olinuxino-Micro,
which has connectors for all three of them.

The patch was run-tested against linux-next-20170825.

Signed-off-by: Harald Geyer <harald@ccbib.org>
---
Note: I guess the same change is good for the olinuxino lime boards too.
However I don't have such boards to test, so I don't formally submit a
patch for them.

 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 0b7403e..64c993a 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -256,6 +256,18 @@
 
 #include "axp209.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
+&battery_power_supply {
+	status = "okay";
+};
+
+&usb_power_supply {
+	status = "okay";
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
-- 
2.1.4
