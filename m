From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon,  2 Oct 2017 14:08:53 +0200
Subject: [PATCH v3 11/12] ARM: dtsi: axp81x: add GPIO DT node
In-Reply-To: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
Message-ID: <20171002120854.5212-12-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds DT node for the GPIO/pinctrl part present in AXP813/AXP818.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/axp81x.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index 73b761f850c5..f90f257130d5 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -48,6 +48,12 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp_gpio: axp_gpio {
+		compatible = "x-powers,axp813-gpio";
+		gpio-controller;
+		#gpio-cells = <2>;
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
2.11.0
