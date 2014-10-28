From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 28 Oct 2014 17:50:43 +0800
Subject: [PATCH 6/6] ARM: dts: sun9i: Enable uart4 for A80 Optimus board
In-Reply-To: <1414489843-2680-1-git-send-email-wens@csie.org>
References: <1414489843-2680-1-git-send-email-wens@csie.org>
Message-ID: <1414489843-2680-7-git-send-email-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The A80 Optimus board exposes uart4 on the GPIO expansion header.
Enable it so we can use it.

Also enable the internal pull-ups, as there doesn't seem to be
external pull-up resistors for pins on the expansion header.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun9i-a80-optimus.dts | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/arm/boot/dts/sun9i-a80-optimus.dts b/arch/arm/boot/dts/sun9i-a80-optimus.dts
index 91eda76..105a324 100644
--- a/arch/arm/boot/dts/sun9i-a80-optimus.dts
+++ b/arch/arm/boot/dts/sun9i-a80-optimus.dts
@@ -71,6 +71,11 @@
 				allwinner,drive = <0>;
 				allwinner,pull = <0>;
 			};
+
+			uart4_pins_a: uart4 at 0 {
+				/* Enable internal pull-up */
+				allwinner,pull = <1>;
+			};
 		};
 
 		uart0: serial at 07000000 {
@@ -79,6 +84,12 @@
 			status = "okay";
 		};
 
+		uart4: serial at 07001000 {
+			pinctrl-names = "default";
+			pinctrl-0 = <&uart4_pins_a>;
+			status = "okay";
+		};
+
 		i2c3: i2c at 07003400 {
 			pinctrl-names = "default";
 			pinctrl-0 = <&i2c3_pins_a>;
-- 
2.1.1
