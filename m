From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Mon, 11 Dec 2017 08:49:59 +0100
Subject: [PATCH 2/4] arm: dts: sun8i: a83t: Add registers needed for MCPM
In-Reply-To: <20171211075001.6100-1-mylene.josserand@free-electrons.com>
References: <20171211075001.6100-1-mylene.josserand@free-electrons.com>
Message-ID: <20171211075001.6100-3-mylene.josserand@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add 3 registers needed for MCPM (ie SMP): prcm, cpucfg and r_cpucfg.
prcm and cpucfg are identical with sun9i-a80. The only difference
is the r_cpucfg that does not exist on sun9i.

Signed-off-by: Myl?ne Josserand <mylene.josserand@free-electrons.com>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index a384b766f3dc..eeb2e7d0d6dc 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -323,6 +323,16 @@
 			#reset-cells = <1>;
 		};
 
+		cpucfg at 01700000 {
+			compatible = "allwinner,sun9i-a80-cpucfg";
+			reg = <0x01700000 0x100>;
+		};
+
+		r_cpucfg at 1f01c00 {
+			compatible = "allwinner,sun8i-a83t-r-cpucfg";
+			reg = <0x1f01c00 0x100>;
+		};
+
 		pio: pinctrl at 1c20800 {
 			compatible = "allwinner,sun8i-a83t-pinctrl";
 			interrupts = <GIC_SPI 15 IRQ_TYPE_LEVEL_HIGH>,
@@ -493,6 +503,11 @@
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		prcm at 1f01400 {
+			compatible = "allwinner,sun9i-a80-prcm";
+			reg = <0x1f01400 0x200>;
+		};
+
 		r_ccu: clock at 1f01400 {
 			compatible = "allwinner,sun8i-a83t-r-ccu";
 			reg = <0x01f01400 0x400>;
-- 
2.11.0
