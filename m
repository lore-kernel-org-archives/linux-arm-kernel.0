From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 26 Feb 2015 15:21:21 +0900
Subject: [PATCH 24/32] ARM: shmobile: emev2-kzm9d dts: Add PFC information for
 uart1
In-Reply-To: <cover.1424849129.git.horms+renesas@verge.net.au>
References: <cover.1424849129.git.horms+renesas@verge.net.au>
Message-ID: <4a5fcc685a84751bbec5653e942fb3d61470a66c.1424849129.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Niklas S?derlund <niso@kth.se>

Configure the pinmux on kzm9d to use the serial connector for uart1.

Signed-off-by: Niklas S?derlund <niso@kth.se>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
Acked-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/emev2-kzm9d.dts | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm/boot/dts/emev2-kzm9d.dts b/arch/arm/boot/dts/emev2-kzm9d.dts
index 667d323..1944627 100644
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
2.1.4
