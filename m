From: zlim@broadcom.com (Zi Shen Lim)
Date: Mon, 12 Jan 2015 18:15:01 -0800
Subject: [PATCH boot-wrapper-aarch64 1/4] psci: use MPIDR_INVALID instead of -1
In-Reply-To: <1421115304-19580-1-git-send-email-zlim@broadcom.com>
References: <1421115304-19580-1-git-send-email-zlim@broadcom.com>
Message-ID: <1421115304-19580-2-git-send-email-zlim@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

MPIDR_INVALID was already defined, so use it.

Signed-off-by: Zi Shen Lim <zlim@broadcom.com>
---
 psci.S | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/psci.S b/psci.S
index 856095b..234493d 100644
--- a/psci.S
+++ b/psci.S
@@ -126,7 +126,7 @@ psci_cpu_on:
 	mov	x0, x1
 
 	bl	find_logical_id
-	cmp	x0, #-1
+	cmp	x0, #MPIDR_INVALID
 	b.eq	1f
 
 	adr	x3, branch_table
@@ -172,7 +172,7 @@ __find_logical_index:
 	b 1b
 2:	mov	x0, x1
 	ret
-3:	mov	x0, #-1
+3:	mov	x0, #MPIDR_INVALID
 	ret
 
 setup_vector:
@@ -207,7 +207,7 @@ spin:
 	ldr	x1, =MPIDR_ID_BITS
 	and	x0, x0, x1
 	bl	find_logical_id
-	cmp	x0, #-1
+	cmp	x0, #MPIDR_INVALID
 	b.eq	spin_dead
 
 	adr	x1, branch_table
-- 
2.1.0
