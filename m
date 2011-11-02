From: javi.merino@arm.com (Javi Merino)
Date: Wed,  2 Nov 2011 14:30:58 +0000
Subject: [PATCH 3/4] ARM: PL330: Fix the size of the dst_cache_ctrl field
In-Reply-To: <1320244259-10496-1-git-send-email-javi.merino@arm.com>
References: <1320244259-10496-1-git-send-email-javi.merino@arm.com>
Message-ID: <1320244259-10496-3-git-send-email-javi.merino@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

dst_cache_ctrl affects bits 3, 1 and 0 of AWCACHE but it is a 3-bit
field in the Channel Control Register (see Table 3-21 of the DMA-330
Technical Reference Manual) and should be programmed as such.

Signed-off-by: Javi Merino <javi.merino@arm.com>
Cc: Jassi Brar <jassi.brar@samsung.com>
---
 arch/arm/include/asm/hardware/pl330.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/hardware/pl330.h b/arch/arm/include/asm/hardware/pl330.h
index 575fa81..c182138 100644
--- a/arch/arm/include/asm/hardware/pl330.h
+++ b/arch/arm/include/asm/hardware/pl330.h
@@ -41,7 +41,7 @@ enum pl330_dstcachectrl {
 	DCCTRL1, /* Bufferable only */
 	DCCTRL2, /* Cacheable, but do not allocate */
 	DCCTRL3, /* Cacheable and bufferable, but do not allocate */
-	DINVALID1 = 8,
+	DINVALID1,              /* AWCACHE = 0x1000 */
 	DINVALID2,
 	DCCTRL6, /* Cacheable write-through, allocate on writes only */
 	DCCTRL7, /* Cacheable write-back, allocate on writes only */
-- 
1.7.0.4
