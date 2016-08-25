From: mathieu.poirier@linaro.org (Mathieu Poirier)
Date: Thu, 25 Aug 2016 15:19:04 -0600
Subject: [PATCH 14/28] hwtracing: coresight: of_coresight: add missing
 of_node_put after calling of_parse_phandle
In-Reply-To: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
References: <1472159958-5981-1-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <1472159958-5981-15-git-send-email-mathieu.poirier@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Peter Chen <peter.chen@nxp.com>

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: linux-arm-kernel at lists.infradead.org
Cc: Mathieu Poirier <mathieu.poirier@linaro.org>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
Signed-off-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/of_coresight.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwtracing/coresight/of_coresight.c b/drivers/hwtracing/coresight/of_coresight.c
index 18f1c8c4776b..629e031b7456 100644
--- a/drivers/hwtracing/coresight/of_coresight.c
+++ b/drivers/hwtracing/coresight/of_coresight.c
@@ -184,6 +184,7 @@ struct coresight_platform_data *of_get_coresight_platform_data(
 			break;
 		}
 	}
+	of_node_put(dn);
 
 	return pdata;
 }
-- 
2.7.4
