From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Tue,  1 May 2018 14:31:23 +0200
Subject: [PATCH v8 04/12] ARM: dts: sun8i: Add R_CPUCFG device node for the
 A83T dtsi
In-Reply-To: <20180501123131.7738-1-mylene.josserand@bootlin.com>
References: <20180501123131.7738-1-mylene.josserand@bootlin.com>
Message-ID: <20180501123131.7738-5-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R_CPUCFG is a collection of registers needed for SMP bringup
on clusters and cluster's reset.
For the moment, documentation about this register is found in
Allwinner's code only.

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index a50ccb475de8..53ace066b7dc 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -938,6 +938,11 @@
 			#reset-cells = <1>;
 		};
 
+		r_cpucfg at 1f01c00 {
+			compatible = "allwinner,sun8i-a83t-r-cpucfg";
+			reg = <0x1f01c00 0x400>;
+		};
+
 		r_pio: pinctrl at 1f02c00 {
 			compatible = "allwinner,sun8i-a83t-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-- 
2.11.0
