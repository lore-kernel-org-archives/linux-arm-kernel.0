From: louis.yu@mediatek.com (Louis Yu)
Date: Thu, 7 Jan 2016 20:09:43 +0800
Subject: [PATCH 1/2] ARM: mediatek: add mt2701 smp bringup code
In-Reply-To: <1452168584-25394-1-git-send-email-louis.yu@mediatek.com>
References: <1452168584-25394-1-git-send-email-louis.yu@mediatek.com>
Message-ID: <1452168584-25394-2-git-send-email-louis.yu@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add support for booting secondary CPUs on mt2701.

Signed-off-by: Louis Yu <louis.yu@mediatek.com>
---
 arch/arm/mach-mediatek/platsmp.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
index 8141f3f..44a5174 100644
--- a/arch/arm/mach-mediatek/platsmp.c
+++ b/arch/arm/mach-mediatek/platsmp.c
@@ -47,6 +47,7 @@ static const struct mtk_smp_boot_info mtk_mt6589_boot = {
 static const struct of_device_id mtk_tz_smp_boot_infos[] __initconst = {
 	{ .compatible   = "mediatek,mt8135", .data = &mtk_mt8135_tz_boot },
 	{ .compatible   = "mediatek,mt8127", .data = &mtk_mt8135_tz_boot },
+	{ .compatible   = "mediatek,mt2701", .data = &mtk_mt8135_tz_boot },
 };
 
 static const struct of_device_id mtk_smp_boot_infos[] __initconst = {
-- 
1.7.9.5
