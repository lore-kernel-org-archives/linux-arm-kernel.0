From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 14 Jan 2011 12:40:51 +0530
Subject: [PATCH] mm/init.c: fix compilation warning
Message-ID: <1294989051-830-1-git-send-email-viresh.kumar@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch fixes following warning:
mm/init.c:606: warning: format '%08lx' expects type 'long unsigned int', but
argument 12 has type 'unsigned int'

Signed-off-by: Viresh Kumar <viresh.kumar@st.com>
---
 arch/arm/mm/init.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 5164069..2d54070 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -593,7 +593,7 @@ void __init mem_init(void)
 #ifdef CONFIG_MMU
 			MLM(CONSISTENT_BASE, CONSISTENT_END),
 #endif
-			MLM(VMALLOC_START, VMALLOC_END),
+			MLM(VMALLOC_START, (unsigned long) VMALLOC_END),
 			MLM(PAGE_OFFSET, (unsigned long)high_memory),
 #ifdef CONFIG_HIGHMEM
 			MLM(PKMAP_BASE, (PKMAP_BASE) + (LAST_PKMAP) *
-- 
1.7.2.2
