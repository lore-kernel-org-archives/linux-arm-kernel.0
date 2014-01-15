From: lauraa@codeaurora.org (Laura Abbott)
Date: Wed, 15 Jan 2014 11:10:56 -0800
Subject: [RESEND][RFC PATCH 1/2] mm/memblock: add memblock_get_current_limit
In-Reply-To: <1389813057-26572-1-git-send-email-lauraa@codeaurora.org>
References: <1389813057-26572-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <1389813057-26572-2-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Appart from setting the limit of memblock, it's also useful to be able
to get the limit to avoid recalculating it every time. Add the function
to do so.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 include/linux/memblock.h |    2 ++
 mm/memblock.c            |    5 +++++
 2 files changed, 7 insertions(+), 0 deletions(-)

diff --git a/include/linux/memblock.h b/include/linux/memblock.h
index 1ef6636..8a20a51 100644
--- a/include/linux/memblock.h
+++ b/include/linux/memblock.h
@@ -252,6 +252,8 @@ static inline void memblock_dump_all(void)
 void memblock_set_current_limit(phys_addr_t limit);
 
 
+phys_addr_t memblock_get_current_limit(void);
+
 /*
  * pfn conversion functions
  *
diff --git a/mm/memblock.c b/mm/memblock.c
index 64ed243..0ec3fc7 100644
--- a/mm/memblock.c
+++ b/mm/memblock.c
@@ -1423,6 +1423,11 @@ void __init_memblock memblock_set_current_limit(phys_addr_t limit)
 	memblock.current_limit = limit;
 }
 
+phys_addr_t __init_memblock memblock_get_current_limit(void)
+{
+	return memblock.current_limit;
+}
+
 static void __init_memblock memblock_dump(struct memblock_type *type, char *name)
 {
 	unsigned long long base, size;
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
