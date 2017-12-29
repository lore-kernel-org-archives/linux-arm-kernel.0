From: mylene.josserand@free-electrons.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri, 29 Dec 2017 11:55:04 +0100
Subject: [PATCH v2 3/5] arm: dts: sun8i: a83t: Add registers needed for MCPM
In-Reply-To: <20171229105506.24851-1-mylene.josserand@free-electrons.com>
References: <20171229105506.24851-1-mylene.josserand@free-electrons.com>
Message-ID: <20171229105506.24851-4-mylene.josserand@free-electrons.com>
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
index de5119a2a91c..a6c69b75fe6c 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -162,6 +162,11 @@
 		#size-cells = <1>;
 		ranges;
 
+		cpucfg at 1700000 {
+			compatible = "allwinner,sun8i-a83t-cpucfg";
+			reg = <0x01700000 0x400>;
+		};
+
 		syscon: syscon at 1c00000 {
 			compatible = "allwinner,sun8i-a83t-system-controller",
 				"syscon";
@@ -595,6 +600,11 @@
 			interrupts = <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>;
 		};
 
+		prcm at 1f01400 {
+			compatible = "allwinner,sun8i-a83t-prcm";
+			reg = <0x1f01400 0x400>;
+		};
+
 		r_ccu: clock at 1f01400 {
 			compatible = "allwinner,sun8i-a83t-r-ccu";
 			reg = <0x01f01400 0x400>;
@@ -605,6 +615,11 @@
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
