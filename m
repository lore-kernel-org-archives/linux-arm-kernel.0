From: will.deacon@arm.com (Will Deacon)
Date: Tue,  7 Jul 2015 18:24:17 +0100
Subject: [PATCH 1/9] locking/qrwlock: include <linux/spinlock.h> for
 arch_spin_{lock, unlock}
In-Reply-To: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
References: <1436289865-2331-1-git-send-email-will.deacon@arm.com>
Message-ID: <1436289865-2331-2-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

locking/qrwlock.c makes use of arch_spin_{lock,unlock}, so ensure that
we #include <linux/spinlock.h> to get their definitions.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 kernel/locking/qrwlock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index d9c36c5f5711..96b77d1e0545 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -20,6 +20,7 @@
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
+#include <linux/spinlock.h>
 #include <asm/qrwlock.h>
 
 /*
-- 
2.1.4
