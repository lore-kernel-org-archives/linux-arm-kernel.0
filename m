From: mamlinav@gmail.com (Aleksei Mamlin)
Date: Fri, 18 Dec 2015 11:52:08 +0300
Subject: [PATCH 2/4] ARM: dts: sun7i: Enable PWM controller on Wexler TAB7200
 tablet
In-Reply-To: <1450428591-5597-1-git-send-email-mamlinav@gmail.com>
References: <1450428591-5597-1-git-send-email-mamlinav@gmail.com>
Message-ID: <1450428728-5695-1-git-send-email-mamlinav@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Wexler TAB7200 tablet use channel 0 of the PWM controller for backlight dimming

Signed-off-by: Aleksei Mamlin <mamlinav@gmail.com>
---
 arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
index ec3b837..1dc9079 100644
--- a/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
+++ b/arch/arm/boot/dts/sun7i-a20-wexler-tab7200.dts
@@ -173,6 +173,12 @@
 	};
 };
 
+&pwm {
+	pinctrl-names = "default";
+	pinctrl-0 = <&pwm0_pins_a>;
+	status = "okay";
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
-- 
2.4.10
