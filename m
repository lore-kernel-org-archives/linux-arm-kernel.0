From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 May 2017 15:31:35 +0800
Subject: [PATCH 3/6] ARM: sun7i: a20: bananapi-m1-plus: Enable AXP209's ACIN
 power supply
In-Reply-To: <20170525073138.20907-1-wens@csie.org>
References: <20170525073138.20907-1-wens@csie.org>
Message-ID: <20170525073138.20907-4-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ACIN pins of the AXP209 PMIC on the Bananapi M1 Plus are tied to the
"power input" micro USB connector next to the SATA connector on the board.

Enable the ACIN power supply.

Signed-off-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
index 4c03cc3fd7b3..eb55e74232c9 100644
--- a/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
+++ b/arch/arm/boot/dts/sun7i-a20-bananapi-m1-plus.dts
@@ -144,6 +144,10 @@
 
 #include "axp209.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
 &ir0 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&ir0_rx_pins_a>;
-- 
2.11.0
