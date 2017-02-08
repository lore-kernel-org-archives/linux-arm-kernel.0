From: dawei.chien@mediatek.com (Dawei Chien)
Date: Wed, 8 Feb 2017 13:31:02 +0800
Subject: [PATCH] thermal: mt8173: minor mtk_thermal.c cleanups
Message-ID: <1486531862-31945-1-git-send-email-dawei.chien@mediatek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thermal driver should read TEMP_MSR3 if thermal bank with 4 sensors.
However, Currently thermal driver don't need read TEMP_MSR3 since
thermal controller only use 3 sensors for each thermal bank.

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
