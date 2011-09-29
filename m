From: jamie@jamieiles.com (Jamie Iles)
Date: Thu, 29 Sep 2011 16:13:22 +0100
Subject: [PATCH] Add missing include of linux/ftrace.h
Message-ID: <1317309202-1001-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

__exception_irq_entry uses __irq_entry which is defined in
linux/ftrace.h.

Reported-by: Zoltan Devai <zdevai@gmail.com>
Cc: Rabin Vincent <rabin@rab.in>
Signed-off-by: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/include/asm/system.h |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/arch/arm/include/asm/system.h b/arch/arm/include/asm/system.h
index 832888d..129e5e5 100644
--- a/arch/arm/include/asm/system.h
+++ b/arch/arm/include/asm/system.h
@@ -59,6 +59,7 @@
 
 #include <linux/linkage.h>
 #include <linux/irqflags.h>
+#include <linux/ftrace.h>
 
 #include <asm/outercache.h>
 
-- 
1.7.4.1
