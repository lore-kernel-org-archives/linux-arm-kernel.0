From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 25 Sep 2017 09:54:32 +0200
Subject: [PATCH] arm64: dts: salvator-common: add 12V regulator to backlight
In-Reply-To: <cover.1506324907.git.horms+renesas@verge.net.au>
References: <cover.1506324907.git.horms+renesas@verge.net.au>
Message-ID: <829e4887b8676255778e162efc57e4a0f18f8bb3.1506324907.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>

This fixes the warning "pwm-backlight backlight: backlight supply power
not found, using dummy regulator".

Fixes: b33be33670217533 ("arm64: dts: salvator-x: Add panel backlight support")
Reported-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Ulrich Hecht <ulrich.hecht+renesas@gmail.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-common.dtsi | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/salvator-common.dtsi b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
index 4786c67b5e65..d9d885006a8e 100644
--- a/arch/arm64/boot/dts/renesas/salvator-common.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-common.dtsi
@@ -62,6 +62,7 @@
 		brightness-levels = <256 128 64 16 8 4 0>;
 		default-brightness-level = <6>;
 
+		power-supply = <&reg_12v>;
 		enable-gpios = <&gpio6 7 GPIO_ACTIVE_HIGH>;
 	};
 
@@ -83,6 +84,15 @@
 		regulator-always-on;
 	};
 
+	reg_12v: regulator2 {
+		compatible = "regulator-fixed";
+		regulator-name = "fixed-12V";
+		regulator-min-microvolt = <12000000>;
+		regulator-max-microvolt = <12000000>;
+		regulator-boot-on;
+		regulator-always-on;
+	};
+
 	rsnd_ak4613: sound {
 		compatible = "simple-audio-card";
 
-- 
2.1.4
