From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 01:00:12 +0900
Subject: [PATCH 2/4] ASoC: bt-sco: Constify platform_device_id
In-Reply-To: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
References: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
Message-ID: <1430496014-32309-2-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 sound/soc/codecs/bt-sco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/codecs/bt-sco.c b/sound/soc/codecs/bt-sco.c
index e7238b8904bc..9d0b794d3005 100644
--- a/sound/soc/codecs/bt-sco.c
+++ b/sound/soc/codecs/bt-sco.c
@@ -63,7 +63,7 @@ static int bt_sco_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct platform_device_id bt_sco_driver_ids[] = {
+static const struct platform_device_id bt_sco_driver_ids[] = {
 	{
 		.name		= "dfbmcs320",
 	},
-- 
2.1.4
