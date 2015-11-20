From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 20 Nov 2015 14:47:12 +0100
Subject: [PATCH 3/4] ARM: dts: sun5i: Enable onboard codec used on the UTOO
 P66 tablet
In-Reply-To: <1448027233-750-1-git-send-email-hdegoede@redhat.com>
References: <1448027233-750-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1448027233-750-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The UTOO P66 tablet uses the A13's integrated audio codec, enable it.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a13-utoo-p66.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
index 2ce9e71..43323f6 100644
--- a/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
+++ b/arch/arm/boot/dts/sun5i-a13-utoo-p66.dts
@@ -72,6 +72,13 @@
 	};
 };
 
+&codec {
+	pinctrl-names = "default";
+	pinctrl-0 = <&codec_pa_pin>;
+	pa-gpios = <&pio 6 3 GPIO_ACTIVE_HIGH>; /* PG3 */
+	status = "okay";
+};
+
 &cpu0 {
 	cpu-supply = <&reg_dcdc2>;
 };
@@ -167,6 +174,13 @@
 };
 
 &pio {
+	codec_pa_pin: codec_pa_pin at 0 {
+		allwinner,pins = "PG3";
+		allwinner,function = "gpio_out";
+		allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+		allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+	};
+
 	mmc0_cd_pin_p66: mmc0_cd_pin at 0 {
 		allwinner,pins = "PG0";
 		allwinner,function = "gpio_in";
-- 
2.5.0
