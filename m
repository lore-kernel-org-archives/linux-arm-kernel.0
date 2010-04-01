From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu,  1 Apr 2010 11:48:56 +0200
Subject: [PATCH] AT91: at91sam9g10 chip identification changed
Message-ID: <1270115336-19488-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A bit in the at91sam9g10 identification number changed between Engineering
Sample and final product. This patch will identify both as being at91sam9g10.

Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/include/mach/cpu.h |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
index 5a06501..833659d 100644
--- a/arch/arm/mach-at91/include/mach/cpu.h
+++ b/arch/arm/mach-at91/include/mach/cpu.h
@@ -21,7 +21,7 @@
 #define ARCH_ID_AT91SAM9260	0x019803a0
 #define ARCH_ID_AT91SAM9261	0x019703a0
 #define ARCH_ID_AT91SAM9263	0x019607a0
-#define ARCH_ID_AT91SAM9G10	0x819903a0
+#define ARCH_ID_AT91SAM9G10	0x019903a0
 #define ARCH_ID_AT91SAM9G20	0x019905a0
 #define ARCH_ID_AT91SAM9RL64	0x019b03a0
 #define ARCH_ID_AT91SAM9G45	0x819b05a0
@@ -108,7 +108,7 @@ static inline unsigned long at91cap9_rev_identify(void)
 #endif
 
 #ifdef CONFIG_ARCH_AT91SAM9G10
-#define cpu_is_at91sam9g10()	(at91_cpu_identify() == ARCH_ID_AT91SAM9G10)
+#define cpu_is_at91sam9g10()	((at91_cpu_identify() & ~AT91_CIDR_EXT)	== ARCH_ID_AT91SAM9G10)
 #else
 #define cpu_is_at91sam9g10()	(0)
 #endif
-- 
1.5.6.5
