From: javi.merino@arm.com (Javi Merino)
Date: Wed,  2 Nov 2011 14:30:59 +0000
Subject: [PATCH 4/4] ARM: PL330: Fix typo in _prepare_ccr()
In-Reply-To: <1320244259-10496-1-git-send-email-javi.merino@arm.com>
References: <1320244259-10496-1-git-send-email-javi.merino@arm.com>
Message-ID: <1320244259-10496-4-git-send-email-javi.merino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

scctl should be shifted by CC_SRCCTRL_SHFT and dcctl by
CC_DSTCCTRL_SHFT, not the other way round.

Signed-off-by: Javi Merino <javi.merino@arm.com>
Cc: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/common/pl330.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/common/pl330.c b/arch/arm/common/pl330.c
index 590fd57..1817963 100644
--- a/arch/arm/common/pl330.c
+++ b/arch/arm/common/pl330.c
@@ -1211,8 +1211,8 @@ static inline u32 _prepare_ccr(const struct pl330_reqcfg *rqc)
 	ccr |= (rqc->brst_size << CC_SRCBRSTSIZE_SHFT);
 	ccr |= (rqc->brst_size << CC_DSTBRSTSIZE_SHFT);
 
-	ccr |= (rqc->dcctl << CC_SRCCCTRL_SHFT);
-	ccr |= (rqc->scctl << CC_DSTCCTRL_SHFT);
+	ccr |= (rqc->scctl << CC_SRCCCTRL_SHFT);
+	ccr |= (rqc->dcctl << CC_DSTCCTRL_SHFT);
 
 	ccr |= (rqc->swap << CC_SWAP_SHFT);
 
-- 
1.7.0.4
