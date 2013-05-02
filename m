From: nm@ti.com (Nishanth Menon)
Date: Thu, 2 May 2013 12:20:11 -0500
Subject: [PATCH v3 2/5] ARM: dts: OMAP36xx: Add device node for ABB
In-Reply-To: <1367515215-30753-1-git-send-email-nm@ti.com>
References: <1367515215-30753-1-git-send-email-nm@ti.com>
Message-ID: <1367515215-30753-3-git-send-email-nm@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: "Andrii.Tseglytskyi" <andrii.tseglytskyi@ti.com>

Add ABB device node for OMAP36xx family of devices. Data is based on
OMAP36XX Technical Reference Manual revision AB (Dec 2012).

[nm at ti.com: co-developer]
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Andrii.Tseglytskyi <andrii.tseglytskyi@ti.com>
---
 arch/arm/boot/dts/omap3.dtsi    |    5 +++++
 arch/arm/boot/dts/omap36xx.dtsi |   20 ++++++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/arm/boot/dts/omap3.dtsi b/arch/arm/boot/dts/omap3.dtsi
index 58c6ed6..5d97201 100644
--- a/arch/arm/boot/dts/omap3.dtsi
+++ b/arch/arm/boot/dts/omap3.dtsi
@@ -75,6 +75,11 @@
 			ti,hwmods = "counter_32k";
 		};
 
+		sysclk: sys {
+			#clock-cells = <0>;
+			compatible = "ti,omap-clock";
+		};
+
 		dpll1: dpll1 {
 			#clock-cells = <0>;
 			compatible = "ti,omap-clock";
diff --git a/arch/arm/boot/dts/omap36xx.dtsi b/arch/arm/boot/dts/omap36xx.dtsi
index f3447bc..38cdcb0 100644
--- a/arch/arm/boot/dts/omap36xx.dtsi
+++ b/arch/arm/boot/dts/omap36xx.dtsi
@@ -34,5 +34,25 @@
 			ti,hwmods = "uart4";
 			clock-frequency = <48000000>;
 		};
+
+		abb_mpu_iva: regulator-abb-mpu {
+			compatible = "ti,abb-v1";
+			regulator-name = "abb_mpu_iva";
+			#address-cell = <0>;
+			#size-cells = <0>;
+			reg = <0x483072f0 0x8>, <0x48306818 0x4>;
+			reg-names = "base-address", "int-address";
+			ti,tranxdone-status-mask = <0x4000000>;
+			clocks = <&sysclk>;
+			ti,settling-time = <30>;
+			ti,clock-cycles = <8>;
+			ti,abb_info = <
+			/*uV		ABB	efuse	rbb_m	fbb_m	vset_m*/
+			1012500		0	0	0	0	0
+			1200000		0	0	0	0	0
+			1325000		0	0	0	0	0
+			1375000		1	0	0	0	0
+			>;
+		};
 	};
 };
-- 
1.7.9.5
