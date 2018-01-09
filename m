From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  9 Jan 2018 10:33:35 +0100
Subject: [PATCH v2 04/16] ARM: dtsi: axp209: add node for ADC
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
Message-ID: <d4de180d7f9555c3851f29a8c34d1f706cafd83e.1515486346.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a DT node for the ADC of the PMIC so that there can be
consumers of its IIO channels declaring their consumptions via DT.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/axp209.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp209.dtsi b/arch/arm/boot/dts/axp209.dtsi
index 897103e..a2e0052 100644
--- a/arch/arm/boot/dts/axp209.dtsi
+++ b/arch/arm/boot/dts/axp209.dtsi
@@ -58,6 +58,11 @@
 		status = "disabled";
 	};
 
+	axp_adc: axp-adc {
+		compatible = "x-powers,axp20x-adc";
+		#io-channel-cells = <1>;
+	};
+
 	axp_gpio: gpio {
 		compatible = "x-powers,axp209-gpio";
 		gpio-controller;
-- 
git-series 0.9.1
