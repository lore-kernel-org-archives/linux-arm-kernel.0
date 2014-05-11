From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 11 May 2014 09:46:56 +0200
Subject: [PATCH v12 5/6] ARM: dts: sun6i: Add reg_vcc3v3 to sun6i board mmc
 nodes
In-Reply-To: <1399794417-9291-1-git-send-email-hdegoede@redhat.com>
References: <1399794417-9291-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399794417-9291-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31-m9.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 22eacf8..bc6115d 100644
--- a/arch/arm/boot/dts/sun6i-a31-m9.dts
+++ b/arch/arm/boot/dts/sun6i-a31-m9.dts
@@ -11,6 +11,7 @@
 
 /dts-v1/;
 /include/ "sun6i-a31.dtsi"
+/include/ "sunxi-common-regulators.dtsi"
 
 / {
 	model = "Mele M9 / A1000G Quad top set box";
@@ -24,6 +25,7 @@
 		mmc0: mmc at 01c0f000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_m9>;
+			vmmc-supply = <&reg_vcc3v3>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 22 0>; /* PH22 */
 			cd-inverted;
-- 
1.9.0
