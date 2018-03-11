From: amonakov@ispras.ru (Alexander Monakov)
Date: Sun, 11 Mar 2018 19:00:03 +0300
Subject: [PATCH 3/8] ARM: dts: berlin2cd: move PMU node from soc to root
In-Reply-To: <20180311160008.22928-1-amonakov@ispras.ru>
References: <20180311160008.22928-1-amonakov@ispras.ru>
Message-ID: <20180311160008.22928-4-amonakov@ispras.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cortex-A9 PMU has no associated memory ranges and "make dtbs W=1" warns
about missing reg or ranges property. To avoid the warning, move the PMU
node out of soc subtree to the root.

Signed-off-by: Alexander Monakov <amonakov@ispras.ru>
---
 arch/arm/boot/dts/berlin2cd.dtsi | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/berlin2cd.dtsi b/arch/arm/boot/dts/berlin2cd.dtsi
index 8c8bf3194f34..572e99ce5940 100644
--- a/arch/arm/boot/dts/berlin2cd.dtsi
+++ b/arch/arm/boot/dts/berlin2cd.dtsi
@@ -73,6 +73,12 @@
 		};
 	};
 
+	pmu {
+		compatible = "arm,cortex-a9-pmu";
+		interrupt-parent = <&gic>;
+		interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
+	};
+
 	refclk: oscillator {
 		compatible = "fixed-clock";
 		#clock-cells = <0>;
@@ -87,11 +93,6 @@
 
 		ranges = <0 0xf7000000 0x1000000>;
 
-		pmu {
-			compatible = "arm,cortex-a9-pmu";
-			interrupts = <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>;
-		};
-
 		sdhci0: sdhci at ab0000 {
 			compatible = "mrvl,pxav3-mmc";
 			reg = <0xab0000 0x200>;
-- 
2.11.0
