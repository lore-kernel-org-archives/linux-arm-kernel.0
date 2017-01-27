From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 27 Jan 2017 09:54:40 +0100
Subject: [PATCH v2 07/25] ARM: dtsi: axp22x: add AXP22X ADC subnode
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Message-ID: <20170127085458.18270-8-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X-Powers AXP22X PMIC has multiple ADCs, each one exposing data from the
different power supplies connected to the PMIC.

This adds the ADC subnode for AXP22X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v2:
 - removed #io-channels property (the IIO channels mapping is done by
 using iio_map structure in the ADC driver),

 arch/arm/boot/dts/axp22x.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index 458b668..abeec81 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -52,6 +52,10 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp221_adc: adc {
+		compatible = "x-powers,axp221-adc";
+	};
+
 	regulators {
 		/* Default work frequency for buck regulators */
 		x-powers,dcdc-freq = <3000>;
-- 
2.9.3
