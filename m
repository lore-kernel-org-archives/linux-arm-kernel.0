From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 10 Jan 2013 21:29:15 +0100
Subject: [PATCH] mmc: mvsdio: Replace IS_ERR_NULL() is with IS_ERR()
Message-ID: <1357849755-8168-1-git-send-email-andrew@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A NULL is a valid clk cookie, so we should not be tested with
IS_ERR_NULL(). Replace it with IS_ERR().

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/mmc/host/mvsdio.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mmc/host/mvsdio.c b/drivers/mmc/host/mvsdio.c
index de4c20b..d0050fa 100644
--- a/drivers/mmc/host/mvsdio.c
+++ b/drivers/mmc/host/mvsdio.c
@@ -839,7 +839,7 @@ out:
 	if (r)
 		release_resource(r);
 	if (mmc)
-		if (!IS_ERR_OR_NULL(host->clk)) {
+		if (!IS_ERR(host->clk)) {
 			clk_disable_unprepare(host->clk);
 			clk_put(host->clk);
 		}
-- 
1.7.10.4
