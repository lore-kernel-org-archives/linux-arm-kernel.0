From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Tue, 18 Apr 2017 09:34:20 +0200
Subject: [PATCH v6 5/6] ARM: dts: sun8i: sina33: enable battery power supply
 subnode
In-Reply-To: <20170418073421.31351-1-quentin.schulz@free-electrons.com>
References: <20170418073421.31351-1-quentin.schulz@free-electrons.com>
Message-ID: <20170418073421.31351-6-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Sinlinx SinA33 has an AXP223 PMIC and a battery connector, thus, we
enable the battery power supply subnode in its Device Tree.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index 9b620cc1d5f1..edc68984fbc8 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -196,6 +196,10 @@
 	status = "okay";
 };
 
+&battery_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-always-on;
 	regulator-min-microvolt = <3000000>;
-- 
2.11.0
