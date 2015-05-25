From: tomeu.vizoso@collabora.com (Tomeu Vizoso)
Date: Mon, 25 May 2015 16:53:25 +0200
Subject: [PATCH 21/21] power-supply: Probe power supplies on demand
In-Reply-To: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
References: <1432565608-26036-1-git-send-email-tomeu.vizoso@collabora.com>
Message-ID: <1432565608-26036-22-git-send-email-tomeu.vizoso@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When looking up a power supply through its DT node, ensure that the
corresponding device has been registered.

Signed-off-by: Tomeu Vizoso <tomeu.vizoso@collabora.com>
---
 drivers/power/power_supply_core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/power/power_supply_core.c b/drivers/power/power_supply_core.c
index 2ed4a4a..3dbfce8 100644
--- a/drivers/power/power_supply_core.c
+++ b/drivers/power/power_supply_core.c
@@ -17,6 +17,7 @@
 #include <linux/device.h>
 #include <linux/notifier.h>
 #include <linux/err.h>
+#include <linux/of_platform.h>
 #include <linux/power_supply.h>
 #include <linux/thermal.h>
 #include "power_supply.h"
@@ -180,6 +181,8 @@ static int power_supply_find_supply_from_node(struct device_node *supply_node)
 {
 	int error;
 
+	of_platform_device_ensure(supply_node);
+
 	/*
 	 * class_for_each_device() either returns its own errors or values
 	 * returned by __power_supply_find_supply_from_node().
-- 
2.4.1
