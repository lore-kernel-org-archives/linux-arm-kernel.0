From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed,  9 Mar 2016 11:50:13 +0100
Subject: [PATCH 3/4] ARM: dt: axp209: Add AXP209 GPIO driver
In-Reply-To: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1457520614-32239-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <1457520614-32239-4-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the AXP209 GPIO node to our AXP209 DTSI so that boards can use it.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/axp209.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 051ab3ba9a65..5430054f7c60 100644
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
2.7.2
