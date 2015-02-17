From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 17 Feb 2015 14:31:55 +0100
Subject: [PATCH 2/2] ARM: shmobile: emev2-kzm9d dts: Add PFC information for
 uart1
In-Reply-To: <1424179915-17417-1-git-send-email-geert+renesas@glider.be>
References: <1424179915-17417-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1424179915-17417-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niso@kth.se>

Configure the pinmux on kzm9d to use the serial connector for uart1.

Signed-off-by: Niklas S?derlund <niso@kth.se>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 667d323e80a3e176..19446273e4a7f832 100644
--- a/arch/arm/boot/dts/emev2-kzm9d.dts
+++ b/arch/arm/boot/dts/emev2-kzm9d.dts
@@ -94,3 +94,16 @@
 		vdd33a-supply = <&reg_3p3v>;
 	};
 };
+
+&pfc {
+	uart1_pins: uart at e1030000 {
+		renesas,groups = "uart1_ctrl", "uart1_data";
+		renesas,function = "uart1";
+	};
+};
+
+&uart1 {
+	pinctrl-0 = <&uart1_pins>;
+	pinctrl-names = "default";
+	status = "okay";
+};
-- 
1.9.1
