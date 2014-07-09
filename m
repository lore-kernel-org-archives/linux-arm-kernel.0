From: a.ryabinin@samsung.com (Andrey Ryabinin)
Date: Wed, 09 Jul 2014 15:30:03 +0400
Subject: [RFC/PATCH RESEND -next 09/21] mm: Makefile: kasan: don't instrument
 slub.c and slab_common.c files
In-Reply-To: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
References: <1404905415-9046-1-git-send-email-a.ryabinin@samsung.com>
Message-ID: <1404905415-9046-10-git-send-email-a.ryabinin@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Code in slub.c and slab_common.c files could validly access to object's
redzones

Signed-off-by: Andrey Ryabinin <a.ryabinin@samsung.com>
---
 mm/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/Makefile b/mm/Makefile
index 6a9c3f8..59cc184 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -3,6 +3,8 @@
 #
 
 KASAN_SANITIZE_page_alloc.o := n
+KASAN_SANITIZE_slab_common.o := n
+KASAN_SANITIZE_slub.o := n
 
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= gup.o highmem.o madvise.o memory.o mincore.o \
-- 
1.8.5.5
