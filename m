From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 May 2017 15:31:34 +0800
Subject: [PATCH 2/6] ARM: sun7i: a20: cubieboard2: Enable AXP209's ACIN power
 supply
In-Reply-To: <20170525073138.20907-1-wens@csie.org>
References: <20170525073138.20907-1-wens@csie.org>
Message-ID: <20170525073138.20907-3-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACIN pins of the AXP209 PMIC on the Cubieboard 2 are tied to the
DC jack on the board.

Enable the ACIN power supply.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-cubieboard2.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
index c21edd75d0b3..2a50207618cb 100644
--- a/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
+++ b/arch/arm/boot/dts/sun7i-a20-cubieboard2.dts
@@ -176,6 +176,10 @@
 
 #include "axp209.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
 &reg_dcdc2 {
 	regulator-always-on;
 	regulator-min-microvolt = <1000000>;
-- 
2.11.0
