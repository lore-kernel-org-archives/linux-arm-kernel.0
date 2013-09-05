From: chander.kashyap@linaro.org (Chander Kashyap)
Date: Thu,  5 Sep 2013 16:59:52 +0530
Subject: [PATCH v3 1/2] clocksource: mct: extend mct to support 8 local
 interrupts for Exynos5420
In-Reply-To: <1378380593-5305-1-git-send-email-chander.kashyap@linaro.org>
References: <1378380593-5305-1-git-send-email-chander.kashyap@linaro.org>
Message-ID: <1378380593-5305-2-git-send-email-chander.kashyap@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Exynos5420 is octacore SoC from Samsung. Hence extend exynos-mct clocksource
driver to support 8 local interrupts.

Also extend dt entries for 8 interrupts.

Signed-off-by: Chander Kashyap <chander.kashyap@linaro.org>
---
 arch/arm/boot/dts/exynos5420.dtsi |    9 +++++++--
 drivers/clocksource/exynos_mct.c  |    4 ++++
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/exynos5420.dtsi b/arch/arm/boot/dts/exynos5420.dtsi
index 6ce2f94..e97c87b 100644
--- a/arch/arm/boot/dts/exynos5420.dtsi
+++ b/arch/arm/boot/dts/exynos5420.dtsi
@@ -69,7 +69,8 @@
 		compatible = "samsung,exynos4210-mct";
 		reg = <0x101C0000 0x800>;
 		interrupt-parent = <&mct_map>;
-		interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>;
+		interrupts = <0>, <1>, <2>, <3>, <4>, <5>, <6>, <7>,
+				<8>, <9>, <10>, <11>;
 		clocks = <&clock 1>, <&clock 315>;
 		clock-names = "fin_pll", "mct";
 
@@ -84,7 +85,11 @@
 					<4 &gic 0 120 0>,
 					<5 &gic 0 121 0>,
 					<6 &gic 0 122 0>,
-					<7 &gic 0 123 0>;
+					<7 &gic 0 123 0>,
+					<8 &gic 0 128 0>,
+					<9 &gic 0 129 0>,
+					<10 &gic 0 130 0>,
+					<11 &gic 0 131 0>;
 		};
 	};
 
diff --git a/drivers/clocksource/exynos_mct.c b/drivers/clocksource/exynos_mct.c
index b2bbc41..ff4711e 100644
--- a/drivers/clocksource/exynos_mct.c
+++ b/drivers/clocksource/exynos_mct.c
@@ -71,6 +71,10 @@ enum {
 	MCT_L1_IRQ,
 	MCT_L2_IRQ,
 	MCT_L3_IRQ,
+	MCT_L4_IRQ,
+	MCT_L5_IRQ,
+	MCT_L6_IRQ,
+	MCT_L7_IRQ,
 	MCT_NR_IRQS,
 };
 
-- 
1.7.9.5
