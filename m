From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sat,  6 Jun 2015 05:57:23 +0200
Subject: [PATCH 1/6] ARM:Gemini:move timer register definitions into the right
 place
In-Reply-To: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
References: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <1433563048-21922-2-git-send-email-ulli.kroll@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We need the offset for the timer registers in driver only.
So move this out of hardware.h

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
---
 arch/arm/mach-gemini/include/mach/hardware.h | 3 ---
 arch/arm/mach-gemini/time.c                  | 4 ++++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-gemini/include/mach/hardware.h b/arch/arm/mach-gemini/include/mach/hardware.h
index 98e7b0f..f0390f1 100644
--- a/arch/arm/mach-gemini/include/mach/hardware.h
+++ b/arch/arm/mach-gemini/include/mach/hardware.h
@@ -57,9 +57,6 @@
 #define GEMINI_USB1_BASE	0x69000000
 #define GEMINI_BIG_ENDIAN_BASE	0x80000000
 
-#define GEMINI_TIMER1_BASE	GEMINI_TIMER_BASE
-#define GEMINI_TIMER2_BASE	(GEMINI_TIMER_BASE + 0x10)
-#define GEMINI_TIMER3_BASE	(GEMINI_TIMER_BASE + 0x20)
 
 /*
  * UART Clock when System clk is 150MHz
diff --git a/arch/arm/mach-gemini/time.c b/arch/arm/mach-gemini/time.c
index 0a63c4d2..d0bbd2f 100644
--- a/arch/arm/mach-gemini/time.c
+++ b/arch/arm/mach-gemini/time.c
@@ -19,6 +19,10 @@
 /*
  * Register definitions for the timers
  */
+#define GEMINI_TIMER1_BASE		GEMINI_TIMER_BASE
+#define GEMINI_TIMER2_BASE		(GEMINI_TIMER_BASE + 0x10)
+#define GEMINI_TIMER3_BASE		(GEMINI_TIMER_BASE + 0x20)
+
 #define TIMER_COUNT(BASE_ADDR)		(BASE_ADDR  + 0x00)
 #define TIMER_LOAD(BASE_ADDR)		(BASE_ADDR  + 0x04)
 #define TIMER_MATCH1(BASE_ADDR)		(BASE_ADDR  + 0x08)
-- 
2.4.2
