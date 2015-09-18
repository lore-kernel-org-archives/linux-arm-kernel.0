From: luis@debethencourt.com (Luis de Bethencourt)
Date: Fri, 18 Sep 2015 19:09:51 +0200
Subject: [PATCH 3/3] regulator: vexpress: Fix module autoload for OF platform
 driver
Message-ID: <20150918170951.GA28327@goodgumbo.baconseed.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This platform driver has a OF device ID table but the OF module
alias information is not created so module autoloading won't work.

Signed-off-by: Luis de Bethencourt <luisbg@osg.samsung.com>
---
 drivers/regulator/vexpress.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/vexpress.c b/drivers/regulator/vexpress.c
index bed9d3e..c810cbb 100644
--- a/drivers/regulator/vexpress.c
+++ b/drivers/regulator/vexpress.c
@@ -103,6 +103,7 @@ static const struct of_device_id vexpress_regulator_of_match[] = {
 	{ .compatible = "arm,vexpress-volt", },
 	{ }
 };
+MODULE_DEVICE_TABLE(of, vexpress_regulator_of_match);
 
 static struct platform_driver vexpress_regulator_driver = {
 	.probe = vexpress_regulator_probe,
-- 
2.4.6
