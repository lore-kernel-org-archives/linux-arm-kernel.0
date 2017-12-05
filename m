From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue,  5 Dec 2017 16:10:26 +0100
Subject: [PATCH v3 14/15] ARM: dts: sun8i: a711: Reinstate the PMIC compatible
In-Reply-To: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
References: <cover.825a49a4c1c565a548f3de0375e7537e7e8fd3a4.1512486553.git-series.maxime.ripard@free-electrons.com>
Message-ID: <25b482f19587ff195582995c11ee9d07f5bf42d2.1512486553.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we added the regulator support in commit 90c5d7cdae64 ("ARM: dts:
sun8i: a711: Add regulator support"), we also dropped the PMIC's
compatible. Since it's not in the PMIC DTSI, unlike most other PMIC
DTSI, it obviously wasn't probing anymore.

Re-add it so that everything works again.

Fixes: 90c5d7cdae64 ("ARM: dts: sun8i: a711: Add regulator support")
Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 98715538932f..a021ee6da396 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -146,6 +146,7 @@
 	status = "okay";
 
 	axp81x: pmic at 3a3 {
+		compatible = "x-powers,axp813";
 		reg = <0x3a3>;
 		interrupt-parent = <&r_intc>;
 		interrupts = <0 IRQ_TYPE_LEVEL_LOW>;
-- 
git-series 0.9.1
