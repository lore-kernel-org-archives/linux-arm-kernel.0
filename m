From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 18 Apr 2017 09:34:21 +0200
Subject: [PATCH v6 6/6] ARM: sun5i: chip: enable battery power supply subnode
In-Reply-To: <20170418073421.31351-1-quentin.schulz@free-electrons.com>
References: <20170418073421.31351-1-quentin.schulz@free-electrons.com>
Message-ID: <20170418073421.31351-7-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The NextThing Co. CHIP has an AXP209 PMIC with battery connector.

This enables the battery power supply subnode.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun5i-r8-chip.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun5i-r8-chip.dts b/arch/arm/boot/dts/sun5i-r8-chip.dts
index d0785602663b..879a4b0f3bd5 100644
--- a/arch/arm/boot/dts/sun5i-r8-chip.dts
+++ b/arch/arm/boot/dts/sun5i-r8-chip.dts
@@ -132,6 +132,10 @@
 	status = "okay";
 };
 
+&battery_power_supply {
+	status = "okay";
+};
+
 &i2c1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&i2c1_pins_a>;
-- 
2.11.0
