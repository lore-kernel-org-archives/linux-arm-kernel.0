From: mylene.josserand@bootlin.com (=?UTF-8?q?Myl=C3=A8ne=20Josserand?=)
Date: Fri, 20 Apr 2018 23:10:13 +0200
Subject: [PATCH v7 02/11] ARM: dts: sun8i: Add CPUCFG device node for A83T dtsi
In-Reply-To: <20180420211022.11759-1-mylene.josserand@bootlin.com>
References: <20180420211022.11759-1-mylene.josserand@bootlin.com>
Message-ID: <20180420211022.11759-3-mylene.josserand@bootlin.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

As we found in sun9i-a80, CPUCFG is a collection of registers that are
mapped to the SoC's signals from each individual processor core and
associated peripherals.

These registers are used for SMP bringup and CPU hotplugging.

Signed-off-by: Myl?ne Josserand <mylene.josserand@bootlin.com>
Reviewed-by: Chen-Yu Tsai <wens@csie.org>
---
 arch/arm/boot/dts/sun8i-a83t.dtsi | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/arch/arm/boot/dts/sun8i-a83t.dtsi b/arch/arm/boot/dts/sun8i-a83t.dtsi
index 568307639be8..32992afa0b12 100644
--- a/arch/arm/boot/dts/sun8i-a83t.dtsi
+++ b/arch/arm/boot/dts/sun8i-a83t.dtsi
@@ -349,6 +349,11 @@
 			};
 		};
 
+		cpucfg at 1700000 {
+			compatible = "allwinner,sun8i-a83t-cpucfg";
+			reg = <0x01700000 0x400>;
+		};
+
 		syscon: syscon at 1c00000 {
 			compatible = "allwinner,sun8i-a83t-system-controller",
 				"syscon";
-- 
2.11.0
