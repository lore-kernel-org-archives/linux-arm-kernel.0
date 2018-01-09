From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue,  9 Jan 2018 10:33:36 +0100
Subject: [PATCH v2 05/16] ARM: dtsi: axp22x: add node for ADC
In-Reply-To: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
References: <cover.1e46d70f7931be8154b450a2fcdf066450a1aa6f.1515486346.git-series.quentin.schulz@free-electrons.com>
Message-ID: <11a72fb582c129bbcbe53dccfadd4fa7b0505af8.1515486346.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This adds a DT node for the ADC of the PMIC so that there can be
consumers of its IIO channels declaring their consumptions via DT.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/axp22x.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/axp22x.dtsi b/arch/arm/boot/dts/axp22x.dtsi
index 87fb08e..fbb7f6e 100644
--- a/arch/arm/boot/dts/axp22x.dtsi
+++ b/arch/arm/boot/dts/axp22x.dtsi
@@ -57,6 +57,11 @@
 		status = "disabled";
 	};
 
+	axp_adc: axp-adc {
+		compatible = "x-powers,axp22x-adc";
+		#io-channel-cells = <1>;
+	};
+
 	battery_power_supply: battery-power-supply {
 		compatible = "x-powers,axp221-battery-power-supply";
 		status = "disabled";
-- 
git-series 0.9.1
