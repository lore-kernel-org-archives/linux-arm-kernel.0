From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Fri, 27 Jan 2017 09:54:39 +0100
Subject: [PATCH v2 06/25] ARM: dtsi: axp209: add AXP209 ADC subnode
In-Reply-To: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
References: <20170127085458.18270-1-quentin.schulz@free-electrons.com>
Message-ID: <20170127085458.18270-7-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

X-Powers AXP209 PMIC has multiple ADCs, each one exposing data from the
different power supplies connected to the PMIC.

This adds the ADC subnode for AXP20X PMIC.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---

v2:
 - removed #io-channels property (the IIO channels mapping is done by
 using iio_map structure in the ADC driver),

 arch/arm/boot/dts/axp209.dtsi | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 675bb0f..00f6ff5 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -53,6 +53,10 @@
 	interrupt-controller;
 	#interrupt-cells = <1>;
 
+	axp209_adc: adc {
+		compatible = "x-powers,axp209-adc";
+	};
+
 	axp_gpio: gpio {
 		compatible = "x-powers,axp209-gpio";
 		gpio-controller;
-- 
2.9.3
