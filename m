From: eric.auger@linaro.org (Eric Auger)
Date: Mon,  1 Sep 2014 10:36:08 +0200
Subject: [PATCH] KVM: EVENTFD: remove inclusion of irq.h
Message-ID: <1409560568-6911-1-git-send-email-eric.auger@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

No more needed. irq.h would be void on ARM.

Signed-off-by: Eric Auger <eric.auger@linaro.org>

---

I don't think irq.h is needed anymore since Paul Mackerras' work. However
I did not compile for all architectures.
---
 virt/kvm/eventfd.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/virt/kvm/eventfd.c b/virt/kvm/eventfd.c
index 3c5981c..0c712a7 100644
--- a/virt/kvm/eventfd.c
+++ b/virt/kvm/eventfd.c
@@ -36,7 +36,6 @@
 #include <linux/seqlock.h>
 #include <trace/events/kvm.h>
 
-#include "irq.h"
 #include "iodev.h"
 
 #ifdef CONFIG_HAVE_KVM_IRQFD
-- 
1.9.1
