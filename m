From: amwang@redhat.com (Cong Wang)
Date: Sat, 23 Jun 2012 18:04:13 +0800
Subject: [PATCH 02/12] arm: remove km_type definitions
In-Reply-To: <1340445863-16111-1-git-send-email-amwang@redhat.com>
References: <1340445863-16111-1-git-send-email-amwang@redhat.com>
Message-ID: <1340445863-16111-3-git-send-email-amwang@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Cong Wang <amwang@redhat.com>
---
 arch/arm/include/asm/kmap_types.h |   26 +-------------------------
 1 files changed, 1 insertions(+), 25 deletions(-)

diff --git a/arch/arm/include/asm/kmap_types.h b/arch/arm/include/asm/kmap_types.h
index e51b1e8..83eb2f7 100644
--- a/arch/arm/include/asm/kmap_types.h
+++ b/arch/arm/include/asm/kmap_types.h
@@ -4,30 +4,6 @@
 /*
  * This is the "bare minimum".  AIO seems to require this.
  */
-enum km_type {
-	KM_BOUNCE_READ,
-	KM_SKB_SUNRPC_DATA,
-	KM_SKB_DATA_SOFTIRQ,
-	KM_USER0,
-	KM_USER1,
-	KM_BIO_SRC_IRQ,
-	KM_BIO_DST_IRQ,
-	KM_PTE0,
-	KM_PTE1,
-	KM_IRQ0,
-	KM_IRQ1,
-	KM_SOFTIRQ0,
-	KM_SOFTIRQ1,
-	KM_L1_CACHE,
-	KM_L2_CACHE,
-	KM_KDB,
-	KM_TYPE_NR
-};
-
-#ifdef CONFIG_DEBUG_HIGHMEM
-#define KM_NMI		(-1)
-#define KM_NMI_PTE	(-1)
-#define KM_IRQ_PTE	(-1)
-#endif
+#define KM_TYPE_NR 16
 
 #endif
-- 
1.7.7.6
