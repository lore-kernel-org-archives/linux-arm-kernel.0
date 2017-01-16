From: fisaksen@baylibre.com (Frode Isaksen)
Date: Mon, 16 Jan 2017 18:03:09 +0100
Subject: [PATCH] ARM: dts: da850-lcdk: enable pwm nodes
Message-ID: <1484586189-3118-1-git-send-email-fisaksen@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable the ecap1 and ecap2 pwm nodes for the
lcdk board.
Note that the other pwm nodes are not enabled,
since the pins are shared with ethernet and spi.

Signed-off-by: Frode Isaksen <fisaksen@baylibre.com>
---
 arch/arm/boot/dts/da850-lcdk.dts | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
index 60e027e..6f4c367 100644
--- a/arch/arm/boot/dts/da850-lcdk.dts
+++ b/arch/arm/boot/dts/da850-lcdk.dts
@@ -322,3 +322,15 @@
 		};
 	};
 };
+
+&ecap1 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ecap1_pins>;
+	status = "okay";
+};
+
+&ecap2 {
+	pinctrl-names = "default";
+	pinctrl-0 = <&ecap2_pins>;
+	status = "okay";
+};
-- 
2.7.4
