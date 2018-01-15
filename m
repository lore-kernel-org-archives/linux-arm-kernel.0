From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 15 Jan 2018 11:33:49 +0100
Subject: [PATCH v3 15/16] ARM: dtsi: sun8i: a711: enable battery power supply
 subnode
In-Reply-To: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
References: <cover.2e5329bf5475a5160e613a4eb1e1377c662ce56e.1516012352.git-series.quentin.schulz@free-electrons.com>
Message-ID: <ac46e3ff9fd2137177bcc5185a44abf29f448be2.1516012352.git-series.quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The TBS A711 has an AXP813 PMIC and a soldered battery, thus, we enable
the battery power supply subnode in its Device Tree.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 511fca4..1de362f 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -231,6 +231,10 @@
 
 #include "axp81x.dtsi"
 
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-min-microvolt = <1800000>;
 	regulator-max-microvolt = <1800000>;
-- 
git-series 0.9.1
