From: thomas@m3y3r.de (Thomas Meyer)
Date: Thu, 21 Sep 2017 08:24:27 +0200
Subject: [PATCH 1/3] ARM: mediatek: Cocci spatch "of_table"
In-Reply-To: <1505974912018-1637125348-0-diffsplit-thomas@m3y3r.de>
References: <1505974912018-1637125348-0-diffsplit-thomas@m3y3r.de>
Message-ID: <1505974912018-1713366490-1-diffsplit-thomas@m3y3r.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make sure (of/i2c/platform)_device_id tables are NULL terminated.
Found by coccinelle spatch "misc/of_table.cocci"

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/arch/arm/mach-mediatek/platsmp.c b/arch/arm/mach-mediatek/platsmp.c
--- a/arch/arm/mach-mediatek/platsmp.c
+++ b/arch/arm/mach-mediatek/platsmp.c
@@ -54,12 +54,14 @@ static const struct of_device_id mtk_tz_
 	{ .compatible   = "mediatek,mt8135", .data = &mtk_mt8135_tz_boot },
 	{ .compatible   = "mediatek,mt8127", .data = &mtk_mt8135_tz_boot },
 	{ .compatible   = "mediatek,mt2701", .data = &mtk_mt8135_tz_boot },
+	{},
 };
 
 static const struct of_device_id mtk_smp_boot_infos[] __initconst = {
 	{ .compatible   = "mediatek,mt6589", .data = &mtk_mt6589_boot },
 	{ .compatible   = "mediatek,mt7623", .data = &mtk_mt7623_boot },
 	{ .compatible   = "mediatek,mt7623a", .data = &mtk_mt7623_boot },
+	{},
 };
 
 static void __iomem *mtk_smp_base;
