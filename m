From: fabf@skynet.be (Fabian Frederick)
Date: Fri, 14 Nov 2014 21:34:37 +0100
Subject: [PATCH 1/1 linux-next] ARM: edma: remove unnecessary sizeof(s8)
Message-ID: <1415997277-4521-1-git-send-email-fabf@skynet.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

sizeof(s8) is always 1

Signed-off-by: Fabian Frederick <fabf@skynet.be>
---
 arch/arm/common/edma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/common/edma.c b/arch/arm/common/edma.c
index 72041f0..d6659fd 100644
--- a/arch/arm/common/edma.c
+++ b/arch/arm/common/edma.c
@@ -1486,8 +1486,7 @@ static int edma_setup_from_hw(struct device *dev, struct edma_soc_info *pdata,
 	 * priority. So Q0 is the highest priority queue and the last queue has
 	 * the lowest priority.
 	 */
-	queue_priority_map = devm_kzalloc(dev,
-					  (edma_cc->num_tc + 1) * sizeof(s8),
+	queue_priority_map = devm_kzalloc(dev, edma_cc->num_tc + 1,
 					  GFP_KERNEL);
 	if (!queue_priority_map)
 		return -ENOMEM;
-- 
1.9.3
