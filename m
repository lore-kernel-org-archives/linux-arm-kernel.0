From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Tue, 20 Aug 2013 13:22:45 +0200
Subject: [PATCH] ARM: EXYNOS: fix PL330 MDMA1 address in DT for Universal C210
 board
Message-ID: <8667689.9TcYbn9cHO@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Revision 0 of Exynos4210 SoC (used on Universal C210 board) requires
'secure' PL330 MDMA1 address (0x12840000) instead of 'non-secure' one
(0x12850000). Fix it by overriding the default PL330 MDMA1 address in
exynos4210-universal_c210.dts.

This is a Device Tree (DT) version of commit 91280e7 ("ARM: EXYNOS:
PL330 MDMA1 fix for revision 0 of Exynos4210 SOC") and fixes recent
regression caused by conversion to DT-only setup on ARM EXYNOS.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 arch/arm/boot/dts/exynos4210-universal_c210.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/boot/dts/exynos4210-universal_c210.dts b/arch/arm/boot/dts/exynos4210-universal_c210.dts
index 889cdad..d2e3f5f 100644
--- a/arch/arm/boot/dts/exynos4210-universal_c210.dts
+++ b/arch/arm/boot/dts/exynos4210-universal_c210.dts
@@ -350,3 +350,7 @@
 		status = "okay";
 	};
 };
+
+&mdma1 {
+	reg = <0x12840000 0x1000>;
+};
-- 
1.8.2.3
