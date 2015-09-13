From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 13 Sep 2015 20:26:01 +0200
Subject: [PATCH] ARM: dts: sun6i: Add accelerometer on Columbus A31
Message-ID: <1442168761-2564-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sander Vermin <sander@vermin.nl>

Add mma8452 accelerometer to sun6i-a31-colombus.dts.

Signed-off-by: Sander Vermin <sander@vermin.nl>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun6i-a31-colombus.dts | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index 0e51249..f9cf368 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -104,6 +104,13 @@
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c2_pins_a>;
 	status = "okay";
+
+	mma8452: mma8452 at 1d {
+		compatible = "fsl,mma8452";
+		reg = <0x1d>;
+		interrupt-parent = <&pio>;
+		interrupts = <0 9 IRQ_TYPE_LEVEL_LOW>; /* PA9 */
+	};
 };
 
 &mmc0 {
-- 
2.4.3
