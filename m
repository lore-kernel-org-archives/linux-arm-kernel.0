From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 20 Mar 2017 09:16:52 +0100
Subject: [RESEND PATCH v4 8/9] ARM: sun5i: chip: enable ACIN power supply
 subnode
In-Reply-To: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
Message-ID: <20170320081653.8884-9-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NextThing Co. CHIP has an AXP209 PMIC and can be power-supplied by
ACIN via the CHG-IN pin.

This enables the ACIN power supply subnode in the DT.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index c9a1821..d078560 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -128,6 +128,10 @@
 
 #include "axp209.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins_a>;
-- 
2.9.3
