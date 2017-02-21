From: dawei.chien@mediatek.com (Dawei Chien)
Date: Tue, 21 Feb 2017 20:26:52 +0800
Subject: [PATCH v2 1/1] thermal: mt8173: minor mtk_thermal.c cleanups
In-Reply-To: <1487680012-61948-1-git-send-email-dawei.chien@mediatek.com>
References: <1487680012-61948-1-git-send-email-dawei.chien@mediatek.com>
Message-ID: <1487680012-61948-2-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If thermal bank with 4 sensors, thermal driver should read TEMP_MSR3.

However, currently thermal driver would not read TEMP_MSR3 since mt8173
thermal driver only use 3 sensors on each thermal bank at the same time,
so this patch would not effect temperature.
Only if mt mt8173 thermal driver use 4 sensors on any thermal bank, would
read third sensor two times, and lose fourth sensor of vale.

cc: stable at vger.kernel.org
Fixes: b7cf0053738c ("thermal: Add Mediatek thermal driver for mt2701.")
Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
Signed-off-by: Dawei Chien <dawei.chien@mediatek.com>
---
 drivers/thermal/mtk_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/thermal/mtk_thermal.c b/drivers/thermal/mtk_thermal.c
index 34169c3..c124151 100644
--- a/drivers/thermal/mtk_thermal.c
+++ b/drivers/thermal/mtk_thermal.c
@@ -191,7 +191,7 @@ struct mtk_thermal {
 };
 
 const int mt8173_msr[MT8173_NUM_SENSORS_PER_ZONE] = {
-	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2, TEMP_MSR2
+	TEMP_MSR0, TEMP_MSR1, TEMP_MSR2, TEMP_MSR3
 };
 
 const int mt8173_adcpnp[MT8173_NUM_SENSORS_PER_ZONE] = {
-- 
1.9.1
