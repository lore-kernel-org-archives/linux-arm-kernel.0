From: fabf@skynet.be (Fabian Frederick)
Date: Mon, 16 Mar 2015 20:20:33 +0100
Subject: [PATCH 17/35 linux-next] coresight-replicator: constify of_device_id
 array
In-Reply-To: <1426533651-25586-1-git-send-email-fabf@skynet.be>
References: <1426533469-25458-1-git-send-email-fabf@skynet.be>
 <1426533651-25586-1-git-send-email-fabf@skynet.be>
Message-ID: <1426533651-25586-8-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

of_device_id is always used as const.
(See driver.of_match_table and open firmware functions)

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 drivers/coresight/coresight-replicator.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/coresight/coresight-replicator.c b/drivers/coresight/coresight-replicator.c
index cdf0553..75b9abd 100644
--- a/drivers/coresight/coresight-replicator.c
+++ b/drivers/coresight/coresight-replicator.c
@@ -107,7 +107,7 @@ static int replicator_remove(struct platform_device *pdev)
 	return 0;
 }
 
-static struct of_device_id replicator_match[] = {
+static const struct of_device_id replicator_match[] = {
 	{.compatible = "arm,coresight-replicator"},
 	{}
 };
-- 
2.1.0
