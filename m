From: weiyj.lk@gmail.com (Wei Yongjun)
Date: Sun, 23 Oct 2016 11:42:57 +0000
Subject: [PATCH -next] ARM: mediatek: add terminate entry for of_device_id
 tables
Message-ID: <1477222977-1336-1-git-send-email-weiyj.lk@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Make sure of_device_id tables are NULL terminated.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
---
 arch/arm/mach-mediatek/platsmp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
index b821e34..e6cffc7 100644
--- a/arch/arm/mach-mediatek/platsmp.c
+++ b/arch/arm/mach-mediatek/platsmp.c
@@ -54,11 +54,13 @@ static const struct of_device_id mtk_tz_smp_boot_infos[] __initconst = {
 	{ .compatible   = "mediatek,mt8135", .data = &mtk_mt8135_tz_boot },
 	{ .compatible   = "mediatek,mt8127", .data = &mtk_mt8135_tz_boot },
 	{ .compatible   = "mediatek,mt2701", .data = &mtk_mt8135_tz_boot },
+	{ },
 };
 
 static const struct of_device_id mtk_smp_boot_infos[] __initconst = {
 	{ .compatible   = "mediatek,mt6589", .data = &mtk_mt6589_boot },
 	{ .compatible   = "mediatek,mt7623", .data = &mtk_mt7623_boot },
+	{ },
 };
 
 static void __iomem *mtk_smp_base;
