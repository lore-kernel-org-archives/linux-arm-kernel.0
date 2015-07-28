From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Tue, 28 Jul 2015 15:19:33 +0200
Subject: [PATCH v2 02/22] of/platform: Set fwnode field for new devices
In-Reply-To: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1438089593-7696-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1438089593-7696-3-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When allocating a new platform device, set the fwnode field in the
struct device to point to the device_node.

This is needed by platform-independent code that needs to do something
with devices based on the data provided by the firmware.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---

Changes in v2:
- Use set_primary_fwnode()

 drivers/of/platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index ddf8e42c9367..ff27494cda8c 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -139,6 +139,7 @@ struct platform_device *of_device_alloc(struct device_node *np,
 	}
 
 	dev->dev.of_node = of_node_get(np);
+	set_primary_fwnode(&dev->dev, &dev->dev.of_node->fwnode);
 	dev->dev.parent = parent ? : &platform_bus;
 
 	if (bus_id)
-- 
2.4.3
