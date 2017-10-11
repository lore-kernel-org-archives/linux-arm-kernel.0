From: liuwenliang@huawei.com (Abbott Liu)
Date: Wed, 11 Oct 2017 16:22:25 +0800
Subject: [PATCH 09/11] Don't need to map the shadow of KASan's shadow memory
In-Reply-To: <20171011082227.20546-1-liuwenliang@huawei.com>
References: <20171011082227.20546-1-liuwenliang@huawei.com>
Message-ID: <20171011082227.20546-10-liuwenliang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Because the KASan's shadow memory don't need to track,so remove the
 mapping code in kasan_init.

Cc: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 arch/arm/mm/kasan_init.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/mm/kasan_init.c b/arch/arm/mm/kasan_init.c
index 2bf0782..7cfdc39 100644
--- a/arch/arm/mm/kasan_init.c
+++ b/arch/arm/mm/kasan_init.c
@@ -218,10 +218,6 @@ void __init kasan_init(void)
 
 	clear_pgds(KASAN_SHADOW_START, KASAN_SHADOW_END);
 
-	kasan_populate_zero_shadow(
-		kasan_mem_to_shadow((void *)KASAN_SHADOW_START),
-		kasan_mem_to_shadow((void *)KASAN_SHADOW_END));
-
 	kasan_populate_zero_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
 				kasan_mem_to_shadow((void *)-1UL) + 1);
 
-- 
2.9.0
