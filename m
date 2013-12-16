From: rmk+kernel@arm.linux.org.uk (Russell King)
Date: Mon, 16 Dec 2013 21:50:04 +0000
Subject: [PATCH] thermal: imx_thermal: add module device table
Message-ID: <E1Vsg3A-0008Q1-9O@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add the module device table declaration so the module can be loaded
automatically at boot time.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/thermal/imx_thermal.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/drivers/thermal/imx_thermal.c b/drivers/thermal/imx_thermal.c
index 1d6c801c1eb9..230864886775 100644
--- a/drivers/thermal/imx_thermal.c
+++ b/drivers/thermal/imx_thermal.c
@@ -522,6 +522,7 @@ static const struct of_device_id of_imx_thermal_match[] = {
 	{ .compatible = "fsl,imx6q-tempmon", },
 	{ /* end */ }
 };
+MODULE_DEVICE_TABLE(of, of_imx_thermal_match);
 
 static struct platform_driver imx_thermal = {
 	.driver = {
-- 
1.7.4.4
