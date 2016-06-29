From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 29 Jun 2016 20:47:01 +0200
Subject: [PATCH 3/4] ARM: dts: sun5i: Add axp152 pmic node to mk802
In-Reply-To: <1467226022-10525-1-git-send-email-hdegoede@redhat.com>
References: <1467226022-10525-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1467226022-10525-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a node describing the axp152 pmic to the mk802 dts, note there are
no regulator nodes as we do not yet support the regulators on the
axp152.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-mk802.dts | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-mk802.dts b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
index 0bb5755..04120e1 100644
--- a/arch/arm/boot/dts/sun5i-a10s-mk802.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-mk802.dts
@@ -73,6 +73,20 @@
 	status = "okay";
 };
 
+&i2c0 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c0_pins_a>;
+	status = "okay";
+
+	axp152: pmic at 30 {
+		compatible = "x-powers,axp152";
+		reg = <0x30>;
+		interrupts = <0>;
+		interrupt-controller;
+		#interrupt-cells = <1>;
+	};
+};
+
 &mmc0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&mmc0_pins_a>, <&mmc0_cd_pin_mk802>;
-- 
2.7.4
