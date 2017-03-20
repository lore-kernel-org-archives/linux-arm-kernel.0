From: quentin.schulz@free-electrons.com (Quentin Schulz)
Date: Mon, 20 Mar 2017 09:16:51 +0100
Subject: [RESEND PATCH v4 7/9] ARM: dts: sun8i: sina33: enable ACIN power
 supply subnode
In-Reply-To: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
References: <20170320081653.8884-1-quentin.schulz@free-electrons.com>
Message-ID: <20170320081653.8884-8-quentin.schulz@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Sinlinx SinA33 has an AXP223 PMIC and an ACIN connector, thus, we
enable the ACIN power supply in its Device Tree.

Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
Acked-by: Chen-Yu Tsai <wens@csie.org>
Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
index cde14b3..c012afe 100644
--- a/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
+++ b/arch/arm/boot/dts/sun8i-a33-sinlinx-sina33.dts
@@ -174,6 +174,10 @@
 
 #include "axp223.dtsi"
 
+&ac_power_supply {
+	status = "okay";
+};
+
 &reg_aldo1 {
 	regulator-always-on;
 	regulator-min-microvolt = <3000000>;
-- 
2.9.3
