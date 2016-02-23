From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 24 Feb 2016 00:03:17 +0100
Subject: [PATCH 2/2] ARM: dts: sun8i: Enable ir receiver on orangepi pc
In-Reply-To: <1456268597-13692-1-git-send-email-hdegoede@redhat.com>
References: <1456268597-13692-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1456268597-13692-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the ir receiver found on the orangepi pc board.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
index 4b25dcc..dc73b2a 100644
--- a/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
+++ b/arch/arm/boot/dts/sun8i-h3-orangepi-pc.dts
@@ -72,6 +72,12 @@
 	status = "okay";
 };
 
+&ir {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ir_pins_a>;
+	status = "okay";
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin>;
-- 
2.7.1
