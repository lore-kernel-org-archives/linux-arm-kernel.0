From: gang.chen@asianux.com (Chen Gang)
Date: Tue, 29 Jan 2013 19:11:43 +0800
Subject: [PATCH] ARM:common: setting saved_state to NULL after kfree
Message-ID: <5107AE6F.3080206@asianux.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


  need set NULL before return, just like function sa1111_remove has done.
  and better to use sa1111_remove directly, instead of current implementation.


Signed-off-by: Chen Gang <gang.chen@asianux.com>
---
 arch/arm/common/sa1111.c |    4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/arm/common/sa1111.c b/arch/arm/common/sa1111.c
index e57d7e5..4bb8230 100644
--- a/arch/arm/common/sa1111.c
+++ b/arch/arm/common/sa1111.c
@@ -954,9 +954,7 @@ static int sa1111_resume(struct platform_device *dev)
 	 */
 	id = sa1111_readl(sachip->base + SA1111_SKID);
 	if ((id & SKID_ID_MASK) != SKID_SA1111_ID) {
-		__sa1111_remove(sachip);
-		platform_set_drvdata(dev, NULL);
-		kfree(save);
+		sa1111_remove(dev);
 		return 0;
 	}
 
-- 
1.7.10.4
