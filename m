From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Mon, 29 Oct 2012 10:59:55 +0100
Subject: [PATCH 3/4] ARM: dts: exynos4: add node for PL330 MDMA1 controller
In-Reply-To: <1351504796-24788-1-git-send-email-b.zolnierkie@samsung.com>
References: <1351504796-24788-1-git-send-email-b.zolnierkie@samsung.com>
Message-ID: <1351504796-24788-4-git-send-email-b.zolnierkie@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add missing PL330 MDMA1 controller node to the device tree (DT).

[ Currently there is no problem with using 'non-secure' mdma1 address
  instead of 'secure' one on revision 0 of Exynos4210 SOC (as used by
  Universal C210 board) as this SOC revision is unsupported by DT. ]

Cc: Tomasz Figa <t.figa@samsung.com>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4.dtsi         | 6 ++++++
 arch/arm/mach-exynos/mach-exynos4-dt.c | 1 +
 2 files changed, 7 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4.dtsi b/arch/arm/boot/dts/exynos4.dtsi
index a26c3dd..96d4462 100644
--- a/arch/arm/boot/dts/exynos4.dtsi
+++ b/arch/arm/boot/dts/exynos4.dtsi
@@ -244,5 +244,11 @@
 			reg = <0x12690000 0x1000>;
 			interrupts = <0 36 0>;
 		};
+
+		mdma1: mdma at 12850000 {
+			compatible = "arm,pl330", "arm,primecell";
+			reg = <0x12850000 0x1000>;
+			interrupts = <0 34 0>;
+		};
 	};
 };
diff --git a/arch/arm/mach-exynos/mach-exynos4-dt.c b/arch/arm/mach-exynos/mach-exynos4-dt.c
index eadf4b5..d737968 100644
--- a/arch/arm/mach-exynos/mach-exynos4-dt.c
+++ b/arch/arm/mach-exynos/mach-exynos4-dt.c
@@ -77,6 +77,7 @@ static const struct of_dev_auxdata exynos4_auxdata_lookup[] __initconst = {
 				"exynos4210-spi.2", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA0, "dma-pl330.0", NULL),
 	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_PDMA1, "dma-pl330.1", NULL),
+	OF_DEV_AUXDATA("arm,pl330", EXYNOS4_PA_NS_MDMA1, "dma-pl330.2", NULL),
 	{},
 };
 
-- 
1.8.0
