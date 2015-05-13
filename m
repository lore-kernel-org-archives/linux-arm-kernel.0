From: robh@kernel.org (Rob Herring)
Date: Wed, 13 May 2015 10:02:30 -0500
Subject: [PATCH v4 6/6] ARM: mmp: remove unused RTC register definitions
In-Reply-To: <1431529350-4597-1-git-send-email-robh@kernel.org>
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
Message-ID: <1431529350-4597-7-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that register definitions have been moved to the driver, regs-rtc.h is
no longer used and can be removed.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-mmp/include/mach/regs-rtc.h | 23 -----------------------
 1 file changed, 23 deletions(-)
 delete mode 100644 arch/arm/mach-mmp/include/mach/regs-rtc.h

diff --git a/arch/arm/mach-mmp/include/mach/regs-rtc.h b/arch/arm/mach-mmp/include/mach/regs-rtc.h
deleted file mode 100644
index 5bff886..0000000
--- a/arch/arm/mach-mmp/include/mach/regs-rtc.h
+++ /dev/null
@@ -1,23 +0,0 @@
-#ifndef __ASM_MACH_REGS_RTC_H
-#define __ASM_MACH_REGS_RTC_H
-
-#include <mach/addr-map.h>
-
-#define RTC_VIRT_BASE	(APB_VIRT_BASE + 0x10000)
-#define RTC_REG(x)	(*((volatile u32 __iomem *)(RTC_VIRT_BASE + (x))))
-
-/*
- * Real Time Clock
- */
-
-#define RCNR		RTC_REG(0x00)	/* RTC Count Register */
-#define RTAR		RTC_REG(0x04)	/* RTC Alarm Register */
-#define RTSR		RTC_REG(0x08)	/* RTC Status Register */
-#define RTTR		RTC_REG(0x0C)	/* RTC Timer Trim Register */
-
-#define RTSR_HZE	(1 << 3)	/* HZ interrupt enable */
-#define RTSR_ALE	(1 << 2)	/* RTC alarm interrupt enable */
-#define RTSR_HZ		(1 << 1)	/* HZ rising-edge detected */
-#define RTSR_AL		(1 << 0)	/* RTC alarm detected */
-
-#endif /* __ASM_MACH_REGS_RTC_H */
-- 
2.1.0
