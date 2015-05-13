From: robh@kernel.org (Rob Herring)
Date: Wed, 13 May 2015 10:02:29 -0500
Subject: [PATCH v4 5/6] ARM: sa1100: remove unused RTC register definitions
In-Reply-To: <1431529350-4597-1-git-send-email-robh@kernel.org>
References: <1431529350-4597-1-git-send-email-robh@kernel.org>
Message-ID: <1431529350-4597-6-git-send-email-robh@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now that register definitions have been moved to the driver, we can remove
them from machine specific code.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Russell King <linux@arm.linux.org.uk>
Cc: linux-arm-kernel at lists.infradead.org
---
 arch/arm/mach-sa1100/include/mach/SA-1100.h | 34 -----------------------------
 1 file changed, 34 deletions(-)

diff --git a/arch/arm/mach-sa1100/include/mach/SA-1100.h b/arch/arm/mach-sa1100/include/mach/SA-1100.h
index 0ac6cc0..7972617 100644
--- a/arch/arm/mach-sa1100/include/mach/SA-1100.h
+++ b/arch/arm/mach-sa1100/include/mach/SA-1100.h
@@ -858,40 +858,6 @@
 
 
 /*
- * Real-Time Clock (RTC) control registers
- *
- * Registers
- *    RTAR      	Real-Time Clock (RTC) Alarm Register (read/write).
- *    RCNR      	Real-Time Clock (RTC) CouNt Register (read/write).
- *    RTTR      	Real-Time Clock (RTC) Trim Register (read/write).
- *    RTSR      	Real-Time Clock (RTC) Status Register (read/write).
- *
- * Clocks
- *    frtx, Trtx	Frequency, period of the real-time clock crystal
- *              	(32.768 kHz nominal).
- *    frtc, Trtc	Frequency, period of the real-time clock counter
- *              	(1 Hz nominal).
- */
-
-#define RTAR		__REG(0x90010000)  /* RTC Alarm Reg. */
-#define RCNR		__REG(0x90010004)  /* RTC CouNt Reg. */
-#define RTTR		__REG(0x90010008)  /* RTC Trim Reg. */
-#define RTSR		__REG(0x90010010)  /* RTC Status Reg. */
-
-#define RTTR_C  	Fld (16, 0)	/* clock divider Count - 1         */
-#define RTTR_D  	Fld (10, 16)	/* trim Delete count               */
-                	        	/* frtc = (1023*(C + 1) - D)*frtx/ */
-                	        	/*        (1023*(C + 1)^2)         */
-                	        	/* Trtc = (1023*(C + 1)^2)*Trtx/   */
-                	        	/*        (1023*(C + 1) - D)       */
-
-#define RTSR_AL 	0x00000001	/* ALarm detected                  */
-#define RTSR_HZ 	0x00000002	/* 1 Hz clock detected             */
-#define RTSR_ALE	0x00000004	/* ALarm interrupt Enable          */
-#define RTSR_HZE	0x00000008	/* 1 Hz clock interrupt Enable     */
-
-
-/*
  * Power Manager (PM) control registers
  *
  * Registers
-- 
2.1.0
