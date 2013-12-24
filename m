From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 23:19:32 +0900
Subject: [PATCH 02/21] ARM: shmobile: armadillo: dts: Add PWM backlight enable
 GPIO
In-Reply-To: <cover.1387893834.git.horms+renesas@verge.net.au>
References: <cover.1387893834.git.horms+renesas@verge.net.au>
Message-ID: <a0c9efe65e00bd0a9b5b5814f6b3012d61f966f9.1387893834.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>

The Armadillo 800 EVA panel module has a backlight enable signal
connected to GPIO 61. Report this in the backlight DT node.

Signed-off-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
index 4705759..e916aae 100644
--- a/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
+++ b/arch/arm/boot/dts/r8a7740-armadillo800eva-reference.dts
@@ -96,6 +96,7 @@
 		pinctrl-0 = <&backlight_pins>;
 		pinctrl-names = "default";
 		power-supply = <&reg_5p0v>;
+		enable-gpios = <&pfc 61 GPIO_ACTIVE_HIGH>;
 	};
 
 	sound {
-- 
1.8.4
