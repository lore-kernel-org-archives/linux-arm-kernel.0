From: sowani@gmail.com (Atul Sowani)
Date: Sun, 14 Nov 2010 00:01:06 +0530
Subject: [PATCH 2.6.36 1/1 RESEND] kernel SPIN_LOCK_UNLOCKED changed to
	__SPIN_LOCK_UNLOCKED()
Message-ID: <4CDED96A.9080404@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are still some files containing .lock = SPIN_LOCK_UNLOCKED type
assignments which should be converted to __SPIN_LOCK_UNLOCKED().
Corrected spacing between __SPIN_LOCK_UNLOCKED and ( for ARM.

Signed-off-by: Atul Sowani <sowani@gmail.com>
---

diff -uprN a/arch/arm/kernel/smp.c b/arch/arm/kernel/smp.c
--- a/arch/arm/kernel/smp.c	2010-10-21 02:00:22.000000000 +0530
+++ b/arch/arm/kernel/smp.c	2010-11-07 00:47:32.000000000 +0530
@@ -56,7 +56,7 @@ struct ipi_data {
 };

 static DEFINE_PER_CPU(struct ipi_data, ipi_data) = {
-	.lock	= SPIN_LOCK_UNLOCKED,
+	.lock	= __SPIN_LOCK_UNLOCKED(ipi_data.lock),
 };

 enum ipi_msg_type {
diff -uprN a/arch/mips/kernel/vpe.c b/arch/mips/kernel/vpe.c
--- a/arch/mips/kernel/vpe.c	2010-10-21 02:00:22.000000000 +0530
+++ b/arch/mips/kernel/vpe.c	2010-11-07 00:51:37.000000000 +0530
@@ -148,9 +148,9 @@ struct {
 	spinlock_t tc_list_lock;
 	struct list_head tc_list;	/* Thread contexts */
 } vpecontrol = {
-	.vpe_list_lock	= SPIN_LOCK_UNLOCKED,
+	.vpe_list_lock	= __SPIN_LOCK_UNLOCKED(vpecontrol.vpe_list_lock),
 	.vpe_list	= LIST_HEAD_INIT(vpecontrol.vpe_list),
-	.tc_list_lock	= SPIN_LOCK_UNLOCKED,
+	.tc_list_lock	= __SPIN_LOCK_UNLOCKED(vpecontrol.tc_list_lock),
 	.tc_list	= LIST_HEAD_INIT(vpecontrol.tc_list)
 };
diff -uprN a/kernel/cred.c b/kernel/cred.c
--- a/kernel/cred.c	2010-10-21 02:00:22.000000000 +0530
+++ b/kernel/cred.c	2010-11-07 00:52:22.000000000 +0530
@@ -35,7 +35,7 @@ static struct kmem_cache *cred_jar;
 static struct thread_group_cred init_tgcred = {
 	.usage	= ATOMIC_INIT(2),
 	.tgid	= 0,
-	.lock	= SPIN_LOCK_UNLOCKED,
+	.lock	= __SPIN_LOCK_UNLOCKED(init_tgcred.lock),
 };
 #endif

-- 
Atul Sowani (sowani at gmail.com)
http://savannah.gnu.org/users/atul
------------------------------------------------------------------------
