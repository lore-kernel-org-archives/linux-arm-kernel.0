From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 22 Apr 2014 13:01:34 +0200
Subject: [PATCH v8 14/17] ARM: dts: sun6i: Enable the mmc controller on the m9
In-Reply-To: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1398164497-14212-15-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tested on a Mele A1000G Quad.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31-m9.dts | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index c95ee77..a188721 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -21,6 +21,22 @@
 	};
 
 	soc at 01c00000 {
+		mmc0: mmc at 01c0f000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_m9>;
+			cd-gpios = <&pio 7 22 0>; /* PH22 */
+			status = "okay";
+		};
+
+		pio: pinctrl at 01c20800 {
+			mmc0_cd_pin_m9: mmc0_cd_pin at 0 {
+				allwinner,pins = "PH22";
+				allwinner,function = "gpio_in";
+				allwinner,drive = <0>;
+				allwinner,pull = <1>;
+			};
+		};
+
 		uart0: serial at 01c28000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
-- 
1.9.0
