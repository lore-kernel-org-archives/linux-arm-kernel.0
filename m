From: shijie.huang@arm.com (Huang Shijie)
Date: Mon, 30 May 2016 10:12:49 +0800
Subject: [PATCH] arm64: fix the wrong comment
Message-ID: <1464574369-22618-1-git-send-email-shijie.huang@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, we use the 48-bit for the kernel and user by default.
The comment becomes stale. This patch fixes the wrong comment.

Signed-off-by: Huang Shijie <shijie.huang@arm.com>
---
 arch/arm64/mm/proc.S | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index c431787..421386759 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -209,8 +209,8 @@ ENTRY(__cpu_setup)
 	bic	x0, x0, x5			// clear bits
 	orr	x0, x0, x6			// set bits
 	/*
-	 * Set/prepare TCR and TTBR. We use 512GB (39-bit) address range for
-	 * both user and kernel.
+	 * Set/prepare TCR. We use VA_BITS of address range for both
+	 * kernel and user.
 	 */
 	ldr	x10, =TCR_TxSZ(VA_BITS) | TCR_CACHE_FLAGS | TCR_SMP_FLAGS | \
 			TCR_TG_FLAGS | TCR_ASID16 | TCR_TBI0
-- 
2.5.5
