From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Fri, 12 May 2017 15:56:42 +0800
Subject: [PATCH v3 5/9] ARM: mediatek: add MT7623a smp bringup code
In-Reply-To: <cover.1494574682.git.sean.wang@mediatek.com>
References: <cover.1494574682.git.sean.wang@mediatek.com>
Message-ID: <644cc644999cb00bb22dd42bceb60dab97ac5579.1494574682.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

Add support for booting secondary CPUs on MT7623a.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 arch/arm/mach-mediatek/mediatek.c | 2 ++
 arch/arm/mach-mediatek/platsmp.c  | 1 +
 2 files changed, 3 insertions(+)

diff --git a/arch/arm/mach-mediatek/mediatek.c b/arch/arm/mach-mediatek/mediatek.c
index a6e3c98..1b52011 100644
--- a/arch/arm/mach-mediatek/mediatek.c
+++ b/arch/arm/mach-mediatek/mediatek.c
@@ -30,6 +30,7 @@ static void __init mediatek_timer_init(void)
 
 	if (of_machine_is_compatible("mediatek,mt6589") ||
 	    of_machine_is_compatible("mediatek,mt7623") ||
+	    of_machine_is_compatible("mediatek,mt7623a") ||
 	    of_machine_is_compatible("mediatek,mt8135") ||
 	    of_machine_is_compatible("mediatek,mt8127")) {
 		/* turn on GPT6 which ungates arch timer clocks */
@@ -49,6 +50,7 @@ static const char * const mediatek_board_dt_compat[] = {
 	"mediatek,mt6589",
 	"mediatek,mt6592",
 	"mediatek,mt7623",
+	"mediatek,mt7623a",
 	"mediatek,mt8127",
 	"mediatek,mt8135",
 	NULL,
diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
index 726eb69..27d78c9 100644
--- a/arch/arm/mach-mediatek/platsmp.c
+++ b/arch/arm/mach-mediatek/platsmp.c
@@ -59,6 +59,7 @@ static const struct of_device_id mtk_tz_smp_boot_infos[] __initconst = {
 static const struct of_device_id mtk_smp_boot_infos[] __initconst = {
 	{ .compatible   = "mediatek,mt6589", .data = &mtk_mt6589_boot },
 	{ .compatible   = "mediatek,mt7623", .data = &mtk_mt7623_boot },
+	{ .compatible   = "mediatek,mt7623a", .data = &mtk_mt7623_boot },
 };
 
 static void __iomem *mtk_smp_base;
-- 
2.7.4
