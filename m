From: quentin.schulz@bootlin.com (Quentin Schulz)
Date: Mon, 19 Feb 2018 13:47:27 +0100
Subject: [PATCH v4 04/13] ARM: dtsi: axp81x: add node for ADC
In-Reply-To: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
References: <cover.6545459c99a33874413abf619136986f53d2c2a2.1519044068.git-series.quentin.schulz@bootlin.com>
Message-ID: <d64f63d2ef1831406b6fc650ed4d9e3d495bbabb.1519044068.git-series.quentin.schulz@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a DT node for the ADC of the PMIC so that there can be
consumers of its IIO channels declaring their consumptions via DT.

Signed-off-by: Quentin Schulz <quentin.schulz@bootlin.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/axp81x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
index fd55b89..6b5e7bc 100644
--- a/arch/arm/boot/dts/axp81x.dtsi
+++ b/arch/arm/boot/dts/axp81x.dtsi
@@ -48,6 +48,11 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp_adc: adc {
+		compatible = "x-powers,axp813-adc";
+		#io-channel-cells = <1>;
+	};
+
 	axp_gpio: axp-gpio {
 		compatible = "x-powers,axp813-gpio";
 		gpio-controller;
-- 
git-series 0.9.1
