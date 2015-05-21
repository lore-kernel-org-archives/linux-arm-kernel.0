From: hdegoede@redhat.com (Hans de Goede)
Date: Thu, 21 May 2015 14:32:33 +0200
Subject: [PATCH 1/3] ARM: dts: sun7i: Add uart4_pins_b definition
Message-ID: <1432211555-25078-1-git-send-email-hdegoede@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Ring <mail@michael-ring.org>

Some boards (e.g. the BananaPro) use alternative pins for uart4, add a pinmux
entry for these.

Signed-off-by: Michael Ring <mail@michael-ring.org>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
---
 arch/arm/boot/dts/sun7i-a20.dtsi | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20.dtsi b/arch/arm/boot/dts/sun7i-a20.dtsi
index e04cdf9..99d48b4 100644
--- a/arch/arm/boot/dts/sun7i-a20.dtsi
+++ b/arch/arm/boot/dts/sun7i-a20.dtsi
@@ -844,6 +844,13 @@
 				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
 			};
 
+			uart4_pins_b: uart4 at 1 {
+				allwinner,pins = "PH4", "PH5";
+				allwinner,function = "uart4";
+				allwinner,drive = <SUN4I_PINCTRL_10_MA>;
+				allwinner,pull = <SUN4I_PINCTRL_NO_PULL>;
+			};
+
 			uart5_pins_a: uart5 at 0 {
 				allwinner,pins = "PI10", "PI11";
 				allwinner,function = "uart5";
-- 
2.4.1
