From: horms+renesas@verge.net.au (Simon Horman)
Date: Sat, 23 Aug 2014 10:44:18 +0900
Subject: [PATCH 08/11] ARM: shmobile: dma: Use defines instead of hardcoded
 numbers
In-Reply-To: <cover.1408671240.git.horms+renesas@verge.net.au>
References: <cover.1408671240.git.horms+renesas@verge.net.au>
Message-ID: <fe8abe0bc2afb20b126e7e0759081dc0df2cd60d.1408671240.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/dma-register.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-shmobile/dma-register.h b/arch/arm/mach-shmobile/dma-register.h
index 97c40bd..52a2f66 100644
--- a/arch/arm/mach-shmobile/dma-register.h
+++ b/arch/arm/mach-shmobile/dma-register.h
@@ -52,8 +52,8 @@ static const unsigned int dma_ts_shift[] = {
 	((((i) & TS_LOW_BIT) << TS_LOW_SHIFT) |\
 	 (((i) & TS_HI_BIT)  << TS_HI_SHIFT))
 
-#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | 0x800 | TS_INDEX2VAL((xmit_sz)))
-#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | 0x800 | TS_INDEX2VAL((xmit_sz)))
+#define CHCR_TX(xmit_sz) (DM_FIX | SM_INC | RS_ERS | TS_INDEX2VAL((xmit_sz)))
+#define CHCR_RX(xmit_sz) (DM_INC | SM_FIX | RS_ERS | TS_INDEX2VAL((xmit_sz)))
 
 
 /*
-- 
2.0.1
