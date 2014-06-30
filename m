From: hdegoede@redhat.com (Hans de Goede)
Date: Mon, 30 Jun 2014 23:57:53 +0200
Subject: [PATCH 3/9] ARM: dts: sun7i: Add AXP209 support to various boards
In-Reply-To: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
References: <1404165479-23785-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1404165479-23785-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Carlo Caione <carlo@caione.org>

At a node for the axp209, and where necessary the i2c controller to the dts
for various boards. Note the axp209 regulators are omitted as we don't have
any use for them yet, and on some boards were not sure how exactly they are
wired up.

Adding support for just the axp209 without the regulators is still useful, as
it will give us power-button and poweroff support.

Signed-off-by: Carlo Caione <carlo@caione.org>
[hdegoede at redhat.com: Drop the regulator bits for now]
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts     | 10 ++++++++++
 arch/arm/boot/dts/sun7i-a20-cubietruck.dts      | 10 ++++++++++
 arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts       | 16 ++++++++++++++++
 arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts | 10 ++++++++++
 4 files changed, 46 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index a70f0b4..5368098 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -82,6 +82,16 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
 		};
 
 		i2c1: i2c at 01c2b000 {
diff --git a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
index 634d04b..f9ab5d4 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubietruck.dts
@@ -127,6 +127,16 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
 		};
 
 		i2c1: i2c at 01c2b000 {
diff --git a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
index 15c7922..4ee6b44 100644
--- a/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
+++ b/arch/arm/boot/dts/sun7i-a20-i12-tvbox.dts
@@ -111,6 +111,22 @@
 			status = "okay";
 		};
 
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
+		};
+
 		gmac: ethernet at 01c50000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&gmac_pins_mii_a>;
diff --git a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
index 99faff1..aa384b5 100644
--- a/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun7i-a20-olinuxino-micro.dts
@@ -131,6 +131,16 @@
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c0_pins_a>;
 			status = "okay";
+
+			axp209: pmic at 34 {
+				compatible = "x-powers,axp209";
+				reg = <0x34>;
+				interrupt-parent = <&nmi_intc>;
+				interrupts = <0 8>;
+
+				interrupt-controller;
+				#interrupt-cells = <1>;
+			};
 		};
 
 		i2c1: i2c at 01c2b000 {
-- 
2.0.0
