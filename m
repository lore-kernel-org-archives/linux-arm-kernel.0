From: hdegoede@redhat.com (Hans de Goede)
Date: Sun, 20 Sep 2015 08:30:49 -0400
Subject: [PATCH 3/5] ARM: dts: sunxi: Enable PWM controller on Q8 format
 tablets
In-Reply-To: <1442752251-20744-1-git-send-email-hdegoede@redhat.com>
References: <1442752251-20744-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1442752251-20744-4-git-send-email-hdegoede@redhat.com>
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
2.4.3
