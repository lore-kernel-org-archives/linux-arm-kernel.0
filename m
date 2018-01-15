From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 15 Jan 2018 11:33:42 +0100
Subject: [PATCH v3 08/16] ARM: dtsi: axp81x: add node for ADC
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
Message-ID: <eb8f23f57dc9d7d7c87c5eea2f85e90470e27c83.1516012352.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a DT node for the ADC of the PMIC so that there can be
consumers of its IIO channels declaring their consumptions via DT.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
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
