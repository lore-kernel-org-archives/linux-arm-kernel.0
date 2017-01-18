From: wens@csie.org (Chen-Yu Tsai)
Date: Wed, 18 Jan 2017 09:01:05 +0800
Subject: [PATCH] ARM: dts: sun6i: sina31s: Enable USB OTG controller in
 peripheral mode
Message-ID: <20170118010105.20069-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

While the SinA31s does have a proper 5-pin mini USB OTG port, the ID
pin does not seem to work. The pin used in the schematics is always low,
regardless of the attached OTG cable or SoC internal pin bias settings.

The v1.5 board is missing bias resistors shown in the schematics for
earlier revisions, and the connections of the remaining one does not
match the schematics either.

In addition, VBUS for this port is disconnected from the board's 5V
power rail. The board features a pad to solder jumper pins to connect
VBUS to 5V manually.

Given the above and the fact that the board has 5 more USB host ports,
it makes more sense to have the OTG port work in peripheral mode.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun6i-a31s-sina31s.dts | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
index 8743aeed1275..7ff68bdd7109 100644
--- a/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
+++ b/arch/arm/boot/dts/sun6i-a31s-sina31s.dts
@@ -153,6 +153,11 @@
 	regulator-name = "vcc-gmac-phy";
 };
 
+&usb_otg {
+	dr_mode = "peripheral";
+	status = "okay";
+};
+
 &usbphy {
 	status = "okay";
 };
-- 
2.11.0
