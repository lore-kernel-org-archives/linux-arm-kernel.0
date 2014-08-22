From: geoff@infradead.org (Geoff Levand)
Date: Fri, 22 Aug 2014 19:49:16 +0000
Subject: [PATCH 4/9] arm64: Remove unused variable in head.S
In-Reply-To: <cover.1408736066.git.geoff@infradead.org>
References: <cover.1408736066.git.geoff@infradead.org>
Message-ID: <6930ff21b3945aa6a2575f5a8b9bb712fcac688f.1408736066.git.geoff@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove an unused local variable from head.S.  It seems this was never
used even from the initial commit
9703d9d7f77ce129621f7d80a844822e2daa7008 (arm64: Kernel booting and
initialisation), and is a left over from a previous implementation
of __calc_phys_offset.

Signed-off-by: Geoff Levand <geoff@infradead.org>
---
 arch/arm64/kernel/head.S | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index 4019b85..607d4bb 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -377,10 +377,6 @@ ENTRY(__boot_cpu_mode)
 	.long	0
 	.popsection
 
-	.align	3
-2:	.quad	.
-	.quad	PAGE_OFFSET
-
 #ifdef CONFIG_SMP
 	.align	3
 1:	.quad	.
-- 
1.9.1
