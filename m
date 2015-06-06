From: ulli.kroll@googlemail.com (Hans Ulli Kroll)
Date: Sat,  6 Jun 2015 05:57:25 +0200
Subject: [PATCH 3/6] ARM:Gemini:add missing intr state and mask register
In-Reply-To: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
References: <1433563048-21922-1-git-send-email-ulli.kroll@googlemail.com>
Message-ID: <1433563048-21922-4-git-send-email-ulli.kroll@googlemail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For earch timer function we have intr state and mask register.
Add control bits up/down counting for each timer

Signed-off-by: Hans Ulli Kroll <ulli.kroll@googlemail.com>
---
 arch/arm/mach-gemini/time.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/arch/arm/mach-gemini/time.c b/arch/arm/mach-gemini/time.c
index 76e3ca7..a8604a3 100644
--- a/arch/arm/mach-gemini/time.c
+++ b/arch/arm/mach-gemini/time.c
@@ -28,6 +28,8 @@
 #define TIMER_MATCH1(BASE_ADDR)		(IO_ADDRESS(BASE_ADDR) + 0x08)
 #define TIMER_MATCH2(BASE_ADDR)		(IO_ADDRESS(BASE_ADDR) + 0x0C)
 #define TIMER_CR(BASE_ADDR)		(IO_ADDRESS(BASE_ADDR) + 0x30)
+#define TIMER_INTR_STATE		(IO_ADDRESS(GEMINI_TIMER_BASE) + 0x34)
+#define TIMER_INTR_MASK			(IO_ADDRESS(GEMINI_TIMER_BASE) + 0x38)
 
 #define TIMER_1_CR_ENABLE		(1 << 0)
 #define TIMER_1_CR_CLOCK		(1 << 1)
@@ -38,6 +40,21 @@
 #define TIMER_3_CR_ENABLE		(1 << 6)
 #define TIMER_3_CR_CLOCK		(1 << 7)
 #define TIMER_3_CR_INT			(1 << 8)
+#define TIMER_1_CR_UPDOWN		(1 << 9)
+#define TIMER_2_CR_UPDOWN		(1 << 10)
+#define TIMER_3_CR_UPDOWN		(1 << 11)
+
+#define TIMER_1_INT_MATCH1		(1 << 0)
+#define TIMER_1_INT_MATCH2		(1 << 1)
+#define TIMER_1_INT_OVERFLOW		(1 << 2)
+#define TIMER_2_INT_MATCH1		(1 << 3)
+#define TIMER_2_INT_MATCH2		(1 << 4)
+#define TIMER_2_INT_OVERFLOW		(1 << 5)
+#define TIMER_3_INT_MATCH1		(1 << 6)
+#define TIMER_3_INT_MATCH2		(1 << 7)
+#define TIMER_3_INT_OVERFLOW		(1 << 8)
+#define TIMER_INT_ALL_MASK		0x1ff
+
 
 static unsigned int tick_rate;
 
-- 
2.4.2
