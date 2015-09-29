From: hdegoede@redhat.com (Hans de Goede)
Date: Tue, 29 Sep 2015 12:29:50 +0200
Subject: [PATCH v2 resend 3/4] ARM: dts: sunxi: Enable PWM controller on Q8
 format tablets
In-Reply-To: <1443522591-6590-1-git-send-email-hdegoede@redhat.com>
References: <1443522591-6590-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1443522591-6590-4-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Chen-Yu Tsai <wens@csie.org>

Q8 format tablets use channel 0 of the PWM controller for backlight dimming.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
Changes in v2:
-Enable the pwm controller in sunxi-q8-common.dtsi rather then in
 sun8i-q8-common.dtsi
---
 arch/arm/boot/dts/sunxi-q8-common.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sunxi-q8-common.dtsi b/arch/arm/boot/dts/sunxi-q8-common.dtsi
index 17b26ff..b824146 100644
--- a/arch/arm/boot/dts/sunxi-q8-common.dtsi
+++ b/arch/arm/boot/dts/sunxi-q8-common.dtsi
@@ -75,3 +75,9 @@
 		voltage = <400000>;
 	};
 };
+
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins>;
+	status = "okay";
+};
-- 
2.5.0
