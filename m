From: pankaj.dubey@samsung.com (Pankaj Dubey)
Date: Thu, 13 Nov 2014 14:12:49 +0530
Subject: [PATCH 3/3] coresight-replicator: remove .owner field for driver
In-Reply-To: <1415868169-13325-1-git-send-email-pankaj.dubey@samsung.com>
References: <1415868169-13325-1-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <1415868169-13325-4-git-send-email-pankaj.dubey@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is no need of .owner field for driver using
module_platform_driver.

Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
---
 drivers/coresight/coresight-replicator.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/coresight/coresight-replicator.c b/drivers/coresight/coresight-replicator.c
index c879039..a2dfcf9 100644
--- a/drivers/coresight/coresight-replicator.c
+++ b/drivers/coresight/coresight-replicator.c
@@ -117,7 +117,6 @@ static struct platform_driver replicator_driver = {
 	.remove         = replicator_remove,
 	.driver         = {
 		.name   = "coresight-replicator",
-		.owner	= THIS_MODULE,
 		.of_match_table = replicator_match,
 	},
 };
-- 
1.7.9.5
