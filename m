From: lauraa@codeaurora.org (Laura Abbott)
Date: Thu, 11 Sep 2014 15:10:32 -0700
Subject: [PATCH] arm64: pageattr: Correctly adjust unaligned start addresses
In-Reply-To: <54112831.6010800@codeaurora.org>
Message-ID: <1410473432-13381-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The start address needs to be actually updated after it
is detected to be unaligned. Adjust it and the end address
properly.

Reported-by: Zi Shen Lim <zlim.lnx@gmail.com>
Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/mm/pageattr.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/pageattr.c b/arch/arm64/mm/pageattr.c
index 75e744e..bb0ea94 100644
--- a/arch/arm64/mm/pageattr.c
+++ b/arch/arm64/mm/pageattr.c
@@ -46,7 +46,8 @@ static int change_memory_common(unsigned long addr, int numpages,
 	struct page_change_data data;
 
 	if (!IS_ALIGNED(addr, PAGE_SIZE)) {
-		addr &= PAGE_MASK;
+		start &= PAGE_MASK;
+		end = start + size;
 		WARN_ON_ONCE(1);
 	}
 
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
