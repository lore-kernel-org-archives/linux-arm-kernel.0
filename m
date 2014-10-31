From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 31 Oct 2014 11:05:48 +0800
Subject: [PATCH v2 3/6] ARM: dts: sun9i: Enable i2c3 on A80 Optimus board
In-Reply-To: <1414724751-25580-1-git-send-email-wens@csie.org>
References: <1414724751-25580-1-git-send-email-wens@csie.org>
Message-ID: <1414724751-25580-4-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

i2c3 is exposed on the GPIO extension header. Enable it so we can use it.

Also enable internal pull-ups on the pins, as they don't seem to have
external pull-up resistors.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 5d9bc80..955436a 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -59,10 +59,23 @@
 	};
 
 	soc {
+		pio: pinctrl at 06000800 {
+			i2c3_pins_a: i2c3 at 0 {
+				/* Enable internal pull-up */
+				allwinner,pull = <1>;
+			};
+		};
+
 		uart0: serial at 07000000 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&uart0_pins_a>;
 			status = "okay";
 		};
+
+		i2c3: i2c at 07003400 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&i2c3_pins_a>;
+			status = "okay";
+		};
 	};
 };
-- 
2.1.1
