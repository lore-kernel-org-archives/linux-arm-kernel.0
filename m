From: hdegoede@redhat.com (Hans de Goede)
Date: Fri,  5 Jun 2015 21:02:22 +0200
Subject: [PATCH 19/20] ARM: dts: sun8i: Enable USB host on GA10H-A33 tablets
In-Reply-To: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
References: <1433530943-12599-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1433530943-12599-20-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The GA10H tablets not only have an otg connector, but also a normal
usb host connector, enabled support for this.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
index 7520e06..1aefc67 100644
--- a/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
+++ b/arch/arm/boot/dts/sun8i-a33-ga10h-v1.1.dts
@@ -61,6 +61,10 @@
 	};
 };
 
+&ehci0 {
+	status = "okay";
+};
+
 &i2c0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
@@ -109,6 +113,10 @@
 	status = "okay";
 };
 
+&ohci0 {
+	status = "okay";
+};
+
 &pio {
 	mmc0_cd_pin_q8h: mmc0_cd_pin at 0 {
 		allwinner,pins = "PB4";
-- 
2.4.2
