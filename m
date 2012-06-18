From: monstr@monstr.eu (Michal Simek)
Date: Mon, 18 Jun 2012 13:30:08 +0200
Subject: [RFC PATCH 5/8] AMP: smp: Extend number of IPIs
In-Reply-To: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
References: <1340019011-18642-1-git-send-email-monstr@monstr.eu>
Message-ID: <1340019011-18642-6-git-send-email-monstr@monstr.eu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

GIC supports up to 16 IPIs.

Signed-off-by: Michal Simek <monstr@monstr.eu>

---
Please correct me if this code is also designed for different
interrupt controller which doesn't support 16 IPIs.
---
 arch/arm/include/asm/hardirq.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/include/asm/hardirq.h b/arch/arm/include/asm/hardirq.h
index 436e60b..3e9ded5 100644
--- a/arch/arm/include/asm/hardirq.h
+++ b/arch/arm/include/asm/hardirq.h
@@ -5,7 +5,7 @@
 #include <linux/threads.h>
 #include <asm/irq.h>
 
-#define NR_IPI	5
+#define NR_IPI	16
 
 typedef struct {
 	unsigned int __softirq_pending;
-- 
1.7.0.4
