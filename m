From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 19 Aug 2016 10:46:47 +0200
Subject: [PATCH v2] ARM: dts: add PM8058 LEDs to the APQ8060 Dragonboard
Message-ID: <1471596407-4601-1-git-send-email-linus.walleij@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds the PM8058 LEDs as used in the platform.

Cc: linux-arm-msm at vger.kernel.org
Cc: linux-leds at vger.kernel.org
Cc: Andy Gross <andy.gross@linaro.org>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Cc: Jacek Anaszewski <j.anaszewski@samsung.com>
Reviewed-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
ChangeLog v1->v2:
- Rename the infrared LED to "pm8058:infrared:proximitysensor"
---
 arch/arm/boot/dts/qcom-apq8060-dragonboard.dts | 39 ++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
index 0abc93e5bb00..6c0038398ef2 100644
--- a/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
+++ b/arch/arm/boot/dts/qcom-apq8060-dragonboard.dts
@@ -239,6 +239,45 @@
 						};
 					};
 				};
+
+				led at 48 {
+					/*
+					 * The keypad LED @0x48 is routed to
+					 * the sensor board where it is
+					 * connected to an infrared LED
+					 * SFH4650 (60mW, @850nm) next to the
+					 * ambient light and proximity sensor
+					 * Capella Microsystems CM3605.
+					 */
+					compatible = "qcom,pm8058-keypad-led";
+					reg = <0x48>;
+					label = "pm8058:infrared:proximitysensor";
+					default-state = "off";
+				};
+				led at 131 {
+					compatible = "qcom,pm8058-led";
+					reg = <0x131>;
+					label = "pm8058:red";
+					default-state = "off";
+				};
+				led at 132 {
+					/*
+					 * This is actually green too on my
+					 * board, but documented as yellow.
+					 */
+					compatible = "qcom,pm8058-led";
+					reg = <0x132>;
+					label = "pm8058:yellow";
+					default-state = "off";
+					linux,default-trigger = "mmc0";
+				};
+				led at 133 {
+					compatible = "qcom,pm8058-led";
+					reg = <0x133>;
+					label = "pm8058:green";
+					default-state = "on";
+					linux,default-trigger = "heartbeat";
+				};
 			};
 		};
 
-- 
2.7.4
