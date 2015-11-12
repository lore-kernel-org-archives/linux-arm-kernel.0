From: jszhang@marvell.com (Jisheng Zhang)
Date: Thu, 12 Nov 2015 20:00:39 +0800
Subject: [PATCH] drivers: firmware: psci: drop duplicate const from
 psci_of_match
Message-ID: <1447329639-1544-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is to fix below sparse warning:
drivers/firmware/psci.c:427:40: warning: duplicate const

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
---
 drivers/firmware/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index d24f35d..ae70d24 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -424,7 +424,7 @@ out_put_node:
 	return err;
 }
 
-static const struct of_device_id const psci_of_match[] __initconst = {
+static const struct of_device_id psci_of_match[] __initconst = {
 	{ .compatible = "arm,psci",	.data = psci_0_1_init},
 	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
 	{ .compatible = "arm,psci-1.0",	.data = psci_0_2_init},
-- 
2.6.2
