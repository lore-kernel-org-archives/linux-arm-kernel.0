From: hdegoede@redhat.com (Hans de Goede)
Date: Sat, 10 May 2014 11:34:02 +0200
Subject: [PATCH v11 5/6] ARM: dts: sun6i: Add reg_vmmc0 to sun6i boards
In-Reply-To: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
References: <1399714443-12459-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1399714443-12459-6-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31-m9.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-m9.dts b/arch/arm/boot/dts/sun6i-a31-m9.dts
index 22eacf8..6dc00c3 100644
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
+			vmmc-supply = <&reg_vmmc0>;
 			bus-width = <4>;
 			cd-gpios = <&pio 7 22 0>; /* PH22 */
 			cd-inverted;
@@ -45,4 +47,8 @@
 			status = "okay";
 		};
 	};
+
+	reg_vmmc0: vmmc0 {
+		status = "okay";
+	};
 };
-- 
1.9.0
