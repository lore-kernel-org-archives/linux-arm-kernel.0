From: k.kozlowski.k@gmail.com (Krzysztof Kozlowski)
Date: Sat,  2 May 2015 01:00:11 +0900
Subject: [PATCH 1/4] ASoC: au1x: Constify platform_device_id
Message-ID: <1430496014-32309-1-git-send-email-k.kozlowski.k@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The platform_device_id is not modified by the driver and core uses it as
const.

Signed-off-by: Krzysztof Kozlowski <k.kozlowski.k@gmail.com>
---
 sound/soc/au1x/db1200.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index c75995f2779c..58c3164802b8 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -21,7 +21,7 @@
 #include "../codecs/wm8731.h"
 #include "psc.h"
 
-static struct platform_device_id db1200_pids[] = {
+static const struct platform_device_id db1200_pids[] = {
 	{
 		.name		= "db1200-ac97",
 		.driver_data	= 0,
-- 
2.1.4
