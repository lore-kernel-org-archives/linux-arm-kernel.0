From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 20 Apr 2016 11:20:27 +0100
Subject: [PATCH 1/2] drivers: firmware: psci: drop duplicate const from
 psci_of_match
Message-ID: <1461147628-22844-1-git-send-email-lorenzo.pieralisi@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jisheng Zhang <jszhang@marvell.com>

This is to fix below sparse warning:
drivers/firmware/psci.c:mmm:nn: warning: duplicate const

Signed-off-by: Jisheng Zhang <jszhang@marvell.com>
Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
---
 drivers/firmware/psci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/firmware/psci.c b/drivers/firmware/psci.c
index 11bfee8..0ab477ba 100644
--- a/drivers/firmware/psci.c
+++ b/drivers/firmware/psci.c
@@ -563,7 +563,7 @@ out_put_node:
 	return err;
 }
 
-static const struct of_device_id const psci_of_match[] __initconst = {
+static const struct of_device_id psci_of_match[] __initconst = {
 	{ .compatible = "arm,psci",	.data = psci_0_1_init},
 	{ .compatible = "arm,psci-0.2",	.data = psci_0_2_init},
 	{ .compatible = "arm,psci-1.0",	.data = psci_0_2_init},
-- 
2.6.4
