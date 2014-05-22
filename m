From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 22 May 2014 14:48:00 +0200
Subject: [PATCH 2/4] ARM: mvebu: fix indentation of assembly instructions in
 coherency_ll.S
In-Reply-To: <1400762882-10116-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1400762882-10116-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1400762882-10116-3-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This commit does not make any functional change, it only fixes the
indentation of a few assembly instructions in
arch/arm/mach-mvebu/coherency_ll.S.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/mach-mvebu/coherency_ll.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-mvebu/coherency_ll.S b/arch/arm/mach-mvebu/coherency_ll.S
index a5e62c6..7d1b5a5 100644
--- a/arch/arm/mach-mvebu/coherency_ll.S
+++ b/arch/arm/mach-mvebu/coherency_ll.S
@@ -66,10 +66,10 @@ ENTRY(ll_add_cpu_to_smp_group)
 	 * ll_get_cpuid, we can use it to save lr modifing it with the
 	 * following bl
 	 */
-	mov r0, lr
+	mov 	r0, lr
 	bl	ll_get_coherency_base
 	bl	ll_get_cpuid
-	mov lr, r0
+	mov 	lr, r0
 	add	r0, r1, #ARMADA_XP_CFB_CFG_REG_OFFSET
 1:
 	ldrex	r2, [r0]
@@ -108,10 +108,10 @@ ENTRY(ll_disable_coherency)
 	 * ll_get_cpuid, we can use it to save lr modifing it with the
 	 * following bl
 	 */
-	mov r0, lr
+	mov 	r0, lr
 	bl	ll_get_coherency_base
 	bl	ll_get_cpuid
-	mov lr, r0
+	mov 	lr, r0
 	add	r0, r1, #ARMADA_XP_CFB_CTL_REG_OFFSET
 1:
 	ldrex	r2, [r0]
-- 
1.9.3
