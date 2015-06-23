From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 23 Jun 2015 21:41:43 +0200
Subject: [PATCH 3/3] ARM: dts: A10s-OLinuxIno: Add a node for axp152 pmic
In-Reply-To: <1435088503-20776-1-git-send-email-hdegoede@redhat.com>
References: <1435088503-20776-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1435088503-20776-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michal Suchanek <hramrach@gmail.com>

Add a node for axp152 pmic used on the A10s-OLinuxIno SBC.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
index a7e19e4..7b26e17 100644
--- a/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
+++ b/arch/arm/boot/dts/sun5i-a10s-olinuxino-micro.dts
@@ -96,8 +96,15 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c0_pins_a>;
 	status = "okay";
+
+	axp152: pmic at 30 {
+		reg = <0x30>;
+		interrupts = <0>;
+	};
 };
 
+#include "axp152.dtsi"
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins_a>;
-- 
2.3.6
