From: sean.wang@mediatek.com (sean.wang at mediatek.com)
Date: Tue, 13 Feb 2018 17:54:10 +0800
Subject: [PATCH] cpufreq: mediatek: Add mediatek related projects into
 blacklist
Message-ID: <8193c5fd73ee34b59799fdf5c6cc24ca60971d6e.1516693333.git.sean.wang@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sean Wang <sean.wang@mediatek.com>

commit 6066998cbd2b1012a8d5bc9a2957cfd0ad53150e upstream.

Please apply 6066998cbd2b1012a8d5bc9a2957cfd0ad53150e to 4.14.y and 4.15.y

commit edeec420de24 ("cpufreq: dt-platdev: Automatically create cpufreq
device with OPP v2") not added MediaTek SoCs to the blacklist that would
lead to cause an occasional hang or unexpected behaviors on related boards
as kernelci reported and complained on [1] specifically for 4.14 and 4.15
tree. For those reasons, add MediaTek SoCs into cpufreq-dt blacklist.

[1] https://kernelci.org/boot/mt7623n-bananapi-bpi-r2/

Fixes: edeec420de24 (cpufreq: dt-cpufreq: platdev Automatically create device with OPP v2)
Signed-off-by: Andrew-sh Cheng <andrew-sh.cheng@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Cc: Kevin Hilman <khilman@baylibre.com>
---
 drivers/cpufreq/cpufreq-dt-platdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
index a753c50..9e0aa76 100644
--- a/drivers/cpufreq/cpufreq-dt-platdev.c
+++ b/drivers/cpufreq/cpufreq-dt-platdev.c
@@ -111,6 +111,14 @@ static const struct of_device_id blacklist[] __initconst = {
 
 	{ .compatible = "marvell,armadaxp", },
 
+	{ .compatible = "mediatek,mt2701", },
+	{ .compatible = "mediatek,mt2712", },
+	{ .compatible = "mediatek,mt7622", },
+	{ .compatible = "mediatek,mt7623", },
+	{ .compatible = "mediatek,mt817x", },
+	{ .compatible = "mediatek,mt8173", },
+	{ .compatible = "mediatek,mt8176", },
+
 	{ .compatible = "nvidia,tegra124", },
 
 	{ .compatible = "st,stih407", },
-- 
2.7.4
