From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Wed, 9 Aug 2017 18:12:39 +0800
Subject: [PATCH 2/2] cpufreq: mediatek: add support of cpufreq to MT7622 SoC
In-Reply-To: <cover.1502272372.git.sean.wang@mediatek.com>
References: <cover.1502272372.git.sean.wang@mediatek.com>
Message-ID: <8d96863368adb8a0435de9739e458035e6a6233b.1502272372.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

MT7622 is a 64-bit ARMv8 based dual-core SoC (2 * Cortex-A53) with a
single cluster. The hardware is also compatible with the current driver,
so add MT7622 as one of the compatible string list.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/cpufreq/mediatek-cpufreq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/cpufreq/mediatek-cpufreq.c b/drivers/cpufreq/mediatek-cpufreq.c
index 9fa9291..18c4bd9 100644
--- a/drivers/cpufreq/mediatek-cpufreq.c
+++ b/drivers/cpufreq/mediatek-cpufreq.c
@@ -574,6 +574,7 @@ static struct platform_driver mtk_cpufreq_platdrv = {
 /* List of machines supported by this driver */
 static const struct of_device_id mtk_cpufreq_machines[] __initconst = {
 	{ .compatible = "mediatek,mt2701", },
+	{ .compatible = "mediatek,mt7622", },
 	{ .compatible = "mediatek,mt7623", },
 	{ .compatible = "mediatek,mt817x", },
 	{ .compatible = "mediatek,mt8173", },
-- 
2.7.4
