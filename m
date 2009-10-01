From: andreas.fenkart@streamunlimited.com (Andreas Fenkart)
Date: Thu,  1 Oct 2009 12:48:59 +0200
Subject: [PATCH 4/6] Made totalhigh_pages unsigned long.
In-Reply-To: <1254394141-26673-4-git-send-email-andreas.fenkart@streamunlimited.com>
References: <20090810213905.GA4046@n2100.arm.linux.org.uk>
	<1254394141-26673-1-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-2-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-3-git-send-email-andreas.fenkart@streamunlimited.com>
	<1254394141-26673-4-git-send-email-andreas.fenkart@streamunlimited.com>
Message-ID: <1254394141-26673-5-git-send-email-andreas.fenkart@streamunlimited.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Makes it consistent with the extern declaration, used when
CONFIG_HIGHMEM is set

Signed-off-by: Andreas Fenkart <andreas.fenkart@streamunlimited.com>
---
 arch/arm/mm/init.c      |    2 +-
 include/linux/highmem.h |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 2217041..4685611 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -622,7 +622,7 @@ void __init mem_init(void)
 		nr_free_pages() << (PAGE_SHIFT-10),
 		free_pages << (PAGE_SHIFT-10),
 		reserved_pages << (PAGE_SHIFT-10),
-		(unsigned long) (totalhigh_pages << (PAGE_SHIFT-10)));
+		totalhigh_pages << (PAGE_SHIFT-10));
 
 #define MLK(b, t) b, t, ((t) - (b)) >> 10
 #define MLM(b, t) b, t, ((t) - (b)) >> 20
diff --git a/include/linux/highmem.h b/include/linux/highmem.h
index 211ff44..ab2cc20 100644
--- a/include/linux/highmem.h
+++ b/include/linux/highmem.h
@@ -46,7 +46,7 @@ void kmap_flush_unused(void);
 
 static inline unsigned int nr_free_highpages(void) { return 0; }
 
-#define totalhigh_pages 0
+#define totalhigh_pages 0UL
 
 #ifndef ARCH_HAS_KMAP
 static inline void *kmap(struct page *page)
-- 
1.6.4.3
