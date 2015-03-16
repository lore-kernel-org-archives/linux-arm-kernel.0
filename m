From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 16 Mar 2015 20:54:32 +0100
Subject: [PATCH 22/35 linux-next] soc: ti: constify of_device_id array
In-Reply-To: <1426533469-25458-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
Message-ID: <1426535685-25996-1-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/soc/ti/knav_dma.c        | 2 +-
 drivers/soc/ti/knav_qmss_queue.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/ti/knav_dma.c b/drivers/soc/ti/knav_dma.c
index bc1b80e..c467d7a 100644
--- a/drivers/soc/ti/knav_dma.c
+++ b/drivers/soc/ti/knav_dma.c
@@ -791,7 +791,7 @@ static int knav_dma_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id of_match[] = {
+static const struct of_device_id of_match[] = {
 	{ .compatible = "ti,keystone-navigator-dma", },
 	{},
 };
diff --git a/drivers/soc/ti/knav_qmss_queue.c b/drivers/soc/ti/knav_qmss_queue.c
index 6d8646d..dd474e4 100644
--- a/drivers/soc/ti/knav_qmss_queue.c
+++ b/drivers/soc/ti/knav_qmss_queue.c
@@ -1803,7 +1803,7 @@ static int knav_queue_remove(struct platform_device *pdev)
 }
 
 /* Match table for of_platform binding */
-static struct of_device_id keystone_qmss_of_match[] = {
+static const struct of_device_id keystone_qmss_of_match[] = {
 	{ .compatible = "ti,keystone-navigator-qmss", },
 	{},
 };
-- 
2.1.0
