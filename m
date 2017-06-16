From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 16 Jun 2017 15:30:14 +0200
Subject: [PATCH 06/11] arm64: dts: salvator-x: Add missing index to PWM
 pinctrl subnode name
In-Reply-To: <cover.1497617276.git.horms+renesas@verge.net.au>
References: <cover.1497617276.git.horms+renesas@verge.net.au>
Message-ID: <371294fc42c1f9cd634685a515da9eb247fd7d35.1497617276.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

R-Car Gen3 SoCs contain multiple PWM modules.  Hence to avoid conflicts,
pinctrl subnodes for PWM should include indices referring to their
instances.

Fixes: b33be33670217533 ("arm64: dts: salvator-x: Add panel backlight support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm64/boot/dts/renesas/salvator-x.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/renesas/salvator-x.dtsi b/arch/arm64/boot/dts/renesas/salvator-x.dtsi
index 937bdf8842f2..2f5386252aed 100644
--- a/arch/arm64/boot/dts/renesas/salvator-x.dtsi
+++ b/arch/arm64/boot/dts/renesas/salvator-x.dtsi
@@ -417,7 +417,7 @@
 		function = "i2c2";
 	};
 
-	pwm1_pins: pwm {
+	pwm1_pins: pwm1 {
 		groups = "pwm1_a";
 		function = "pwm1";
 	};
-- 
2.1.4
