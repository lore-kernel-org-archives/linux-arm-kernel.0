From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 20 Mar 2013 19:36:24 -0300
Subject: [PATCH 03/16] thermal: mvebu: Move MODULE_DEVICE_TABLE upwards
In-Reply-To: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1363818997-23137-1-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <1363818997-23137-4-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This table will be needed by mvebu_thermal_probe() so we move
it just below the declaration of the compatible device table.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
 drivers/thermal/mvebu_thermal.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/mvebu_thermal.c b/drivers/thermal/mvebu_thermal.c
index d61a750..77c488c 100644
--- a/drivers/thermal/mvebu_thermal.c
+++ b/drivers/thermal/mvebu_thermal.c
@@ -68,6 +68,7 @@ static const struct of_device_id mvebu_thermal_id_table[] = {
 	{ .compatible = "marvell,kirkwood-thermal" },
 	{}
 };
+MODULE_DEVICE_TABLE(of, mvebu_thermal_id_table);
 
 static int mvebu_thermal_probe(struct platform_device *pdev)
 {
@@ -115,8 +116,6 @@ static int mvebu_thermal_exit(struct platform_device *pdev)
 	return 0;
 }
 
-MODULE_DEVICE_TABLE(of, mvebu_thermal_id_table);
-
 static struct platform_driver mvebu_thermal_driver = {
 	.probe = mvebu_thermal_probe,
 	.remove = mvebu_thermal_exit,
-- 
1.7.8.6
