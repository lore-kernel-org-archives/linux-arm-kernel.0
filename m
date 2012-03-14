From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 14 Mar 2012 07:26:26 -0700
Subject: [PATCH 1/5] ARM: EXYNOS: Remove GIC save & restore function
In-Reply-To: <1331735190-28773-1-git-send-email-kgene.kim@samsung.com>
References: <1331735190-28773-1-git-send-email-kgene.kim@samsung.com>
Message-ID: <1331735190-28773-2-git-send-email-kgene.kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jongpill Lee <boyko.lee@samsung.com>

This patch removes GIC save & restore functino in pm.c. Because when
enalbe CPU_PM feature, GIC driver execute save and restore function
in CPU_PM notifier.
So it is not needed to GIC save & restore function at pm.c file.

Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
---
 arch/arm/mach-exynos/pm.c |   83 ---------------------------------------------
 1 files changed, 0 insertions(+), 83 deletions(-)

diff --git a/arch/arm/mach-exynos/pm.c b/arch/arm/mach-exynos/pm.c
index f105bd2..696f0bf 100644
--- a/arch/arm/mach-exynos/pm.c
+++ b/arch/arm/mach-exynos/pm.c
@@ -64,89 +64,6 @@ static struct sleep_save exynos4_vpll_save[] = {
 };
 
 static struct sleep_save exynos4_core_save[] = {
-	/* GIC side */
-	SAVE_ITEM(S5P_VA_GIC_CPU + 0x000),
-	SAVE_ITEM(S5P_VA_GIC_CPU + 0x004),
-	SAVE_ITEM(S5P_VA_GIC_CPU + 0x008),
-	SAVE_ITEM(S5P_VA_GIC_CPU + 0x00C),
-	SAVE_ITEM(S5P_VA_GIC_CPU + 0x014),
-	SAVE_ITEM(S5P_VA_GIC_CPU + 0x018),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x000),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x004),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x100),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x104),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x108),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x300),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x304),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x308),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x400),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x404),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x408),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x40C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x410),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x414),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x418),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x41C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x420),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x424),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x428),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x42C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x430),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x434),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x438),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x43C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x440),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x444),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x448),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x44C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x450),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x454),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x458),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x45C),
-
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x800),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x804),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x808),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x80C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x810),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x814),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x818),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x81C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x820),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x824),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x828),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x82C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x830),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x834),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x838),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x83C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x840),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x844),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x848),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x84C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x850),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x854),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x858),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0x85C),
-
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC00),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC04),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC08),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC0C),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC10),
-	SAVE_ITEM(S5P_VA_GIC_DIST + 0xC14),
-
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x000),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x010),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x020),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x030),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x040),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x050),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x060),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x070),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x080),
-	SAVE_ITEM(S5P_VA_COMBINER_BASE + 0x090),
-
 	/* SROM side */
 	SAVE_ITEM(S5P_SROM_BW),
 	SAVE_ITEM(S5P_SROM_BC0),
-- 
1.7.4.4
