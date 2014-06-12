From: andy.jhshiu@gmail.com (Andy Hsu)
Date: Thu, 12 Jun 2014 08:32:12 -0700
Subject: [PATCH 1/1] Remove an extra operation: The ESR has been stored into
 x1, and should be directly pass to do_sp_pc_abort function
Message-ID: <1402587132-4853-1-git-send-email-andy.jhshiu@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Signed-off-by: Andy Hsu <andy.jhshiu@gmail.com>
---
 arch/arm64/kernel/entry.S |    1 -
 1 files changed, 0 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
index fa78916..56ef569 100644
--- a/arch/arm64/kernel/entry.S
+++ b/arch/arm64/kernel/entry.S
@@ -275,7 +275,6 @@ el1_sp_pc:
 	 * Stack or PC alignment exception handling
 	 */
 	mrs	x0, far_el1
-	mov	x1, x25
 	mov	x2, sp
 	b	do_sp_pc_abort
 el1_undef:
-- 
1.7.0.4
