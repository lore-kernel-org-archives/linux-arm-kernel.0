From: mbohan@codeaurora.org (Michael Bohan)
Date: Thu,  1 Apr 2010 17:20:47 -0700
Subject: [PATCH 1/3] arm: mm: Update mem bank ordering comment to reflect code
In-Reply-To: <>
References: <>
Message-ID: <1270167649-17824-1-git-send-email-mbohan@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Michael Bohan <mbohan@quicinc.com>

The memory banks are now sorted in bootmem_init() -- thus this
code no longer needs fixing.

Change-Id: Idc20f9c34bef416544081c3b5cf33fe120c63759
Signed-off-by: Michael Bohan <mbohan@quicinc.com>
Signed-off-by: Michael Bohan <mbohan@codeaurora.org>
---
 arch/arm/mm/init.c |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mm/init.c b/arch/arm/mm/init.c
index 7829cb5..ab4890f 100644
--- a/arch/arm/mm/init.c
+++ b/arch/arm/mm/init.c
@@ -531,9 +531,8 @@ static void __init free_unused_memmap_node(int node, struct meminfo *mi)
 	unsigned int i;
 
 	/*
-	 * [FIXME] This relies on each bank being in address order.  This
-	 * may not be the case, especially if the user has provided the
-	 * information on the command line.
+	 * This relies on each bank being in address order. The banks
+	 * are sorted previously in bootmem_init().
 	 */
 	for_each_nodebank(i, mi, node) {
 		struct membank *bank = &mi->bank[i];
-- 
1.6.2.3
