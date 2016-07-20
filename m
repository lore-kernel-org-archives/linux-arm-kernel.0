From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 20 Jul 2016 16:11:38 +0200
Subject: [PATCH v2 3/4] ARM: dt: axp209: Add AXP209 GPIO driver
In-Reply-To: <20160720141139.25098-1-maxime.ripard@free-electrons.com>
References: <20160720141139.25098-1-maxime.ripard@free-electrons.com>
Message-ID: <20160720141139.25098-4-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the AXP209 GPIO node to our AXP209 DTSI so that boards can use it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/boot/dts/axp209.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index afbe89c01df5..675bb0f30825 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -53,6 +53,12 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp_gpio: gpio {
+		compatible = "x-powers,axp209-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <1500>;
-- 
2.9.0
