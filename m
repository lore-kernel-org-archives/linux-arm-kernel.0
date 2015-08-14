From: hdegoede@redhat.com (Hans de Goede)
Date: Fri, 14 Aug 2015 16:44:33 +0200
Subject: [PATCH 2/6] ARM: dts: sun7i: Enable i2c bus 1 and 2 on the Wits A20
 Pro DKT
In-Reply-To: <1439563477-12295-1-git-send-email-hdegoede@redhat.com>
References: <1439563477-12295-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1439563477-12295-3-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable i2c bus 1 and 2 on the Wits A20 Pro DKT, these are used for
the touchscreen resp. the accelerometer.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
index da47608..85b500d 100644
--- a/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wits-pro-a20-dkt.dts
@@ -92,6 +92,18 @@
 	};
 };
 
+&i2c1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c1_pins_a>;
+	status = "okay";
+};
+
+&i2c2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&i2c2_pins_a>;
+	status = "okay";
+};
+
 #include "axp209.dtsi"
 
 &mmc0 {
-- 
2.4.3
