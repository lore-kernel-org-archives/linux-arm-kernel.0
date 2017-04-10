From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 11 Apr 2017 01:35:02 +0400
Subject: [PATCH 1/3] kernel/locking: #include <asm/spinlock.h> in qrwlock.c
In-Reply-To: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
References: <1491860104-4103-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1491860104-4103-2-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

qrwlock.c calls arch_spin_lock() and arch_spin_unlock() but doesn't
include the asm/spinlock.h, where those functions are defined. It
may produce "implicit declaration of function" errors. This patch
fixes it.

Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
---
 kernel/locking/qrwlock.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/locking/qrwlock.c b/kernel/locking/qrwlock.c
index cc3ed0c..6fb4292 100644
--- a/kernel/locking/qrwlock.c
+++ b/kernel/locking/qrwlock.c
@@ -20,6 +20,7 @@
 #include <linux/cpumask.h>
 #include <linux/percpu.h>
 #include <linux/hardirq.h>
+#include <asm/spinlock.h>
 #include <asm/qrwlock.h>
 
 /*
-- 
2.7.4
