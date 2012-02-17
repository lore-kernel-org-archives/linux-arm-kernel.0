From: robherring2@gmail.com (Rob Herring)
Date: Thu, 16 Feb 2012 21:32:14 -0600
Subject: [PATCH 4/4] rtc: sa1100: include mach/irqs.h instead of asm/irq.h
In-Reply-To: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
References: <1329449534-23811-1-git-send-email-robherring2@gmail.com>
Message-ID: <1329449534-23811-5-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Since asm/irq.h may not include mach/irqs.h, include mach/irqs.h directly.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 drivers/rtc/rtc-sa1100.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/drivers/rtc/rtc-sa1100.c b/drivers/rtc/rtc-sa1100.c
index cb9a585..e8f1add 100644
--- a/drivers/rtc/rtc-sa1100.c
+++ b/drivers/rtc/rtc-sa1100.c
@@ -32,7 +32,7 @@
 #include <linux/bitops.h>
 
 #include <mach/hardware.h>
-#include <asm/irq.h>
+#include <mach/irqs.h>
 
 #ifdef CONFIG_ARCH_PXA
 #include <mach/regs-rtc.h>
-- 
1.7.5.4
