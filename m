From: lee.jones@linaro.org (Lee Jones)
Date: Fri,  3 May 2013 15:32:45 +0100
Subject: [PATCH 59/63] dmaengine: ste_dma40_ll: Replace meaningless register
 set with comment
In-Reply-To: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
References: <1367591569-32197-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1367591569-32197-60-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Unsure of the author's intentions, rather than just removing the nop,
we're replacing it with a comment containing the possible intention
of the statement OR:ing with 0.

Cc: Vinod Koul <vinod.koul@intel.com>
Cc: Dan Williams <djbw@fb.com>
Cc: Per Forlin <per.forlin@stericsson.com>
Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/dma/ste_dma40_ll.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/ste_dma40_ll.c b/drivers/dma/ste_dma40_ll.c
index a035dfe..27b818d 100644
--- a/drivers/dma/ste_dma40_ll.c
+++ b/drivers/dma/ste_dma40_ll.c
@@ -182,8 +182,10 @@ static int d40_phy_fill_lli(struct d40_phy_lli *lli,
 	else
 		lli->reg_cfg &= ~BIT(D40_SREG_CFG_TIM_POS);
 
-	/* Post link */
-	lli->reg_lnk |= 0 << D40_SREG_LNK_PHY_PRE_POS;
+	/*
+	 * Post link - D40_SREG_LNK_PHY_PRE_POS = 0
+	 * Relink happens after transfer completion.
+	 */
 
 	return 0;
 }
-- 
1.7.10.4
