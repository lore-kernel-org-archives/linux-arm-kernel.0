From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  3 Jun 2016 20:10:40 +0200
Subject: [PATCH] ARM: dts: sun5i-a10s-wobo-i5: Enable ldo4 too
Message-ID: <1464977440-23441-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It seems that the wifi chip is powered by both ldo3 and ldo4 tied
together and that using only one results in the wifi-chip dropping of
the USB bus sometimes.

Ideally we would have a proper way of modelling this (this is being
worked on), but currently we do not. This is not an issue since we need
to keep these regulators always-on anyways, due to these boards
crashing when ldo3/4 get turned back on after having been turned off.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
index 9fea918..52d18ca 100644
--- a/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-wobo-i5.dts
@@ -195,7 +195,14 @@
 	regulator-always-on;
 	regulator-min-microvolt = <3300000>;
 	regulator-max-microvolt = <3300000>;
-	regulator-name = "vcc-wifi";
+	regulator-name = "vcc-wifi1";
+};
+
+&reg_ldo4 {
+	regulator-always-on;
+	regulator-min-microvolt = <3300000>;
+	regulator-max-microvolt = <3300000>;
+	regulator-name = "vcc-wifi2";
 };
 
 &reg_usb1_vbus {
-- 
2.7.4
