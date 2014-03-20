From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 20 Mar 2014 11:11:47 +0000
Subject: [PATCH 5/5] mtd: st_spi_fsm: Succinctly reorganise .remove()
In-Reply-To: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
References: <1395313907-25318-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1395313907-25318-6-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Reported-by: Brian Norris <computersforpeace@gmail.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/mtd/devices/st_spi_fsm.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 921b44a..bea1416 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -2081,13 +2081,8 @@ static int stfsm_probe(struct platform_device *pdev)
 static int stfsm_remove(struct platform_device *pdev)
 {
 	struct stfsm *fsm = platform_get_drvdata(pdev);
-	int err;
 
-	err = mtd_device_unregister(&fsm->mtd);
-	if (err)
-		return err;
-
-	return 0;
+	return mtd_device_unregister(&fsm->mtd);
 }
 
 static struct of_device_id stfsm_match[] = {
-- 
1.8.3.2
