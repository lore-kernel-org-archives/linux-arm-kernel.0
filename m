From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 25 Jan 2012 14:36:32 +0000
Subject: [PATCH 19/33] MFD: ucb1x00-core: add .owner initializer and module
 alias
In-Reply-To: <20120125143000.GF1068@n2100.arm.linux.org.uk>
References: <20120125143000.GF1068@n2100.arm.linux.org.uk>
Message-ID: <E1Rq3xg-0000Z2-0c@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a .owner initializer to the UCB1x00 mcp driver structure, and
set an appropriate module alias to identify this driver.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/mfd/ucb1x00-core.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/drivers/mfd/ucb1x00-core.c b/drivers/mfd/ucb1x00-core.c
index 42eee63..c2757c1 100644
--- a/drivers/mfd/ucb1x00-core.c
+++ b/drivers/mfd/ucb1x00-core.c
@@ -714,6 +714,7 @@ static int ucb1x00_resume(struct mcp *mcp)
 static struct mcp_driver ucb1x00_driver = {
 	.drv		= {
 		.name	= "ucb1x00",
+		.owner	= THIS_MODULE,
 	},
 	.probe		= ucb1x00_probe,
 	.remove		= ucb1x00_remove,
@@ -757,6 +758,7 @@ EXPORT_SYMBOL(ucb1x00_disable_irq);
 EXPORT_SYMBOL(ucb1x00_register_driver);
 EXPORT_SYMBOL(ucb1x00_unregister_driver);
 
+MODULE_ALIAS("mcp:ucb1x00");
 MODULE_AUTHOR("Russell King <rmk@arm.linux.org.uk>");
 MODULE_DESCRIPTION("UCB1x00 core driver");
 MODULE_LICENSE("GPL");
-- 
1.7.4.4
