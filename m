From: Baohua.Song@csr.com (Barry Song)
Date: Mon, 22 Aug 2011 23:15:51 -0700
Subject: [PATCH v2 3/4] ARM: L2X0: move l2x0_init out of .init section
In-Reply-To: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
Message-ID: <1314080152-30503-4-git-send-email-Baohua.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

After resuming, system need to re-init L2

Signed-off-by: Barry Song <Baohua.Song@csr.com>
---
 arch/arm/include/asm/hardware/cache-l2x0.h |    2 +-
 arch/arm/mm/cache-l2x0.c                   |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/include/asm/hardware/cache-l2x0.h b/arch/arm/include/asm/hardware/cache-l2x0.h
index 16bd480..407c849 100644
--- a/arch/arm/include/asm/hardware/cache-l2x0.h
+++ b/arch/arm/include/asm/hardware/cache-l2x0.h
@@ -73,7 +73,7 @@
 #define L2X0_AUX_CTRL_EARLY_BRESP_SHIFT		30
 
 #ifndef __ASSEMBLY__
-extern void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
+extern void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask);
 #endif
 
 #endif
diff --git a/arch/arm/mm/cache-l2x0.c b/arch/arm/mm/cache-l2x0.c
index 44c0867..5891ea0 100644
--- a/arch/arm/mm/cache-l2x0.c
+++ b/arch/arm/mm/cache-l2x0.c
@@ -277,7 +277,7 @@ static void l2x0_disable(void)
 	spin_unlock_irqrestore(&l2x0_lock, flags);
 }
 
-void __init l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
+void l2x0_init(void __iomem *base, __u32 aux_val, __u32 aux_mask)
 {
 	__u32 aux;
 	__u32 cache_id;
-- 
1.7.1



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
