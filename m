From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu,  7 Dec 2017 16:58:59 +0100
Subject: [PATCH v4 14/15] ARM: dts: sun8i: a711: Reinstate the PMIC compatible
In-Reply-To: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
References: <cover.e46a07c0e181d735c807dc94fe0ce0ea013788be.1512662253.git-series.maxime.ripard@free-electrons.com>
Message-ID: <80711a93a5e49166a26ade747687d8ba4ef7a6f3.1512662253.git-series.maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When we added the regulator support in commit 90c5d7cdae64 ("ARM: dts:
sun8i: a711: Add regulator support"), we also dropped the PMIC's
compatible. Since it's not in the PMIC DTSI, unlike most other PMIC
DTSI, it obviously wasn't probing anymore.

Re-add it so that everything works again.

Fixes: 90c5d7cdae64 ("ARM: dts: sun8i: a711: Add regulator support")
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
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
