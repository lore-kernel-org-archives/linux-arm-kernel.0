From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Wed, 17 Jun 2015 15:42:16 +0200
Subject: [PATCH 06/13] of/platform: Set fwnode field for new devices
In-Reply-To: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1434548543-22949-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1434548543-22949-7-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When allocating a new platform device, set the fwnode field in the
struct device to point to the device_node.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/of/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index ddf8e42..e880f55 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -139,6 +139,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	dev->dev.of_node = of_node_get(np);
+	dev->dev.fwnode = &dev->dev.of_node->fwnode;
 	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)
-- 
2.4.1
