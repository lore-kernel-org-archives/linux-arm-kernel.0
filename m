From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Mon, 19 Feb 2018 09:18:34 +0100
Subject: [PATCH v3 4/7] ARM: dts: sun8i: Add R_CPUCFG device node for the A83T
 dtsi
In-Reply-To: <20180219081837.15482-1-mylene.josserand@bootlin.com>
References: <20180219081837.15482-1-mylene.josserand@bootlin.com>
Message-ID: <20180219081837.15482-5-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The R_CPUCFG is a collection of registers needed for SMP bringup
on clusters and cluster's reset.
For the moment, documentation about this register is found in
Allwinner's code only.

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 3e7317ec3e43..7ae631fc04d5 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -714,6 +714,11 @@
 			#reset-cells = <1>;
 		};
 
+		r_cpucfg at 1f01c00 {
+			compatible = "allwinner,sun8i-a83t-r-cpucfg";
+			reg = <0x1f01c00 0x100>;
+		};
+
 		r_pio: pinctrl at 1f02c00 {
 			compatible = "allwinner,sun8i-a83t-r-pinctrl";
 			reg = <0x01f02c00 0x400>;
-- 
2.11.0
