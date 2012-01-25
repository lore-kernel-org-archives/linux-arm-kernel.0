From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:33:48 +0000
Subject: [PATCH 11/33] MFD: mcp-sa11x0: add .owner initializer
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3v2-0000YM-Tu@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Patch partly taken from af9081ae64 (ARM: sa1100: Refactor mcp-sa11x0 to
use platform resources.) by Jochen Friedrich <jochen@scram.de>

Move the MODULE_ALIAS() alongside the other MODULE_* definitions, and
use DRIVER_NAME to ensure that the driver is consistently named.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/mcp-sa11x0.c |   10 ++++------
 1 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/mfd/mcp-sa11x0.c b/drivers/mfd/mcp-sa11x0.c
index 5373a7a..703e76a 100644
--- a/drivers/mfd/mcp-sa11x0.c
+++ b/drivers/mfd/mcp-sa11x0.c
@@ -27,6 +27,7 @@
 
 #include <mach/assabet.h>
 
+#define DRIVER_NAME "sa11x0-mcp"
 
 struct mcp_sa11x0 {
 	u32	mccr0;
@@ -227,18 +228,14 @@ static int mcp_sa11x0_resume(struct platform_device *dev)
 	return 0;
 }
 
-/*
- * The driver for the SA11x0 MCP port.
- */
-MODULE_ALIAS("platform:sa11x0-mcp");
-
 static struct platform_driver mcp_sa11x0_driver = {
 	.probe		= mcp_sa11x0_probe,
 	.remove		= mcp_sa11x0_remove,
 	.suspend	= mcp_sa11x0_suspend,
 	.resume		= mcp_sa11x0_resume,
 	.driver		= {
-		.name	= "sa11x0-mcp",
+		.name	= DRIVER_NAME,
+		.owner	= THIS_MODULE,
 	},
 };
 
@@ -247,6 +244,7 @@ static struct platform_driver mcp_sa11x0_driver = {
  */
 module_platform_driver(mcp_sa11x0_driver);
 
+MODULE_ALIAS("platform:" DRIVER_NAME);
 MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
 MODULE_DESCRIPTION("SA11x0 multimedia communications port driver");
 MODULE_LICENSE("GPL");
-- 
1.7.4.4
