From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 01:00:14 +0900
Subject: [PATCH 4/4] ASoC: samsung: Constify platform_device_id
In-Reply-To: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430496014-32309-4-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 sound/soc/samsung/i2s.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/i2s.c b/sound/soc/samsung/i2s.c
index b92ab40d2be6..ea4ab374a223 100644
--- a/sound/soc/samsung/i2s.c
+++ b/sound/soc/samsung/i2s.c
@@ -1493,7 +1493,7 @@ static const struct samsung_i2s_dai_data samsung_dai_type_sec = {
 	.dai_type = TYPE_SEC,
 };
 
-static struct platform_device_id samsung_i2s_driver_ids[] = {
+static const struct platform_device_id samsung_i2s_driver_ids[] = {
 	{
 		.name           = "samsung-i2s",
 		.driver_data	= (kernel_ulong_t)&i2sv3_dai_type,
-- 
2.1.4
