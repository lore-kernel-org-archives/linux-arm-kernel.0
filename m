From: peter.chen@nxp.com (Peter Chen)
Date: Fri, 1 Jul 2016 17:41:59 +0800
Subject: [PATCH 5/7] bus: vexpress-config: add missing of_node_put after
 calling of_parse_phandle
In-Reply-To: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
References: <1467366121-14120-1-git-send-email-peter.chen@nxp.com>
Message-ID: <1467366121-14120-6-git-send-email-peter.chen@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_node_put needs to be called when the device node which is got
from of_parse_phandle has finished using.

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Signed-off-by: Peter Chen <peter.chen@nxp.com>
---
 drivers/bus/vexpress-config.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index c3cb76b..9efdf1d 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -178,6 +178,7 @@ static int vexpress_config_populate(struct device_node *node)
 
 	parent = class_find_device(vexpress_config_class, NULL, bridge,
 			vexpress_config_node_match);
+	of_node_put(bridge);
 	if (WARN_ON(!parent))
 		return -ENODEV;
 
-- 
1.9.1
