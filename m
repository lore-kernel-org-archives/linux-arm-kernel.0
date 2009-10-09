From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Fri,  9 Oct 2009 11:25:53 +0400
Subject: [PATCH] irda/sa1100_ir: check return value of startup hook
Message-ID: <1255073153-24962-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---
 drivers/net/irda/sa1100_ir.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/irda/sa1100_ir.c b/drivers/net/irda/sa1100_ir.c
index 38bf7cf..df5db2d 100644
--- a/drivers/net/irda/sa1100_ir.c
+++ b/drivers/net/irda/sa1100_ir.c
@@ -232,8 +232,11 @@ static int sa1100_irda_startup(struct sa1100_irda *si)
 	/*
 	 * Ensure that the ports for this device are setup correctly.
 	 */
-	if (si->pdata->startup)
-		si->pdata->startup(si->dev);
+	if (si->pdata->startup)	{
+		ret = si->pdata->startup(si->dev);
+		if (ret)
+			return ret;
+		}
 
 	/*
 	 * Configure PPC for IRDA - we want to drive TXD2 low.
-- 
1.6.3.4
