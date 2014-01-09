From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  9 Jan 2014 18:20:03 +0100
Subject: [PATCH 5/5] ARM: sun6i: colombus: Enable the I2C controllers
In-Reply-To: <1389288003-23187-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1389288003-23187-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1389288003-23187-6-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A31 Colombus board has 3 I2C controllers that should be usable. However,
the first one is not working for some reason on the hardware I have been able
to test it on, while it should really be the same controller. Enable the i2c1
and i2c2 busses, and mark i2c0 as in failure in the DT.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun6i-a31-colombus.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm/boot/dts/sun6i-a31-colombus.dts b/arch/arm/boot/dts/sun6i-a31-colombus.dts
index e5adae3..3898a7b 100644
--- a/arch/arm/boot/dts/sun6i-a31-colombus.dts
+++ b/arch/arm/boot/dts/sun6i-a31-colombus.dts
@@ -28,5 +28,23 @@
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+
+		i2c0: i2c at 01c2ac00 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c0_pins_a>;
+			status = "fail";
+		};
+
+		i2c1: i2c at 01c2b000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c1_pins_a>;
+			status = "okay";
+		};
+
+		i2c2: i2c at 01c2b400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c2_pins_a>;
+			status = "okay";
+		};
 	};
 };
-- 
1.8.4.2
