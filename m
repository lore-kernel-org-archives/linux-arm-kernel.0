From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 23 Apr 2011 04:52:25 +0200
Subject: [PATCH] at91: Add ARCH_ID and basic cpu macros definition for 5series
	chips family.
Message-ID: <1303527145-24492-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
Hi,

	this patch is just an extract of the 5series support send weeks ago
	as we need it for drivers and the soc support will not be present next
	merge window until the rework of the at91 will be weel advanced

Best Regards,
J.
 arch/arm/mach-at91/include/mach/cpu.h |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+), 0 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/cpu.h b/arch/arm/mach-at91/include/mach/cpu.h
index 3bef931..0700f21 100644
--- a/arch/arm/mach-at91/include/mach/cpu.h
+++ b/arch/arm/mach-at91/include/mach/cpu.h
@@ -27,6 +27,7 @@
 #define ARCH_ID_AT91SAM9G45	0x819b05a0
 #define ARCH_ID_AT91SAM9G45MRL	0x819b05a2	/* aka 9G45-ES2 & non ES lots */
 #define ARCH_ID_AT91SAM9G45ES	0x819b05a1	/* 9G45-ES (Engineering Sample) */
+#define ARCH_ID_AT91SAM9X5	0x819a05a0
 #define ARCH_ID_AT91CAP9	0x039A03A0
 
 #define ARCH_ID_AT91SAM9XE128	0x329973a0
@@ -55,6 +56,12 @@ static inline unsigned long at91_cpu_fully_identify(void)
 #define ARCH_EXID_AT91SAM9G46	0x00000003
 #define ARCH_EXID_AT91SAM9G45	0x00000004
 
+#define ARCH_EXID_AT91SAM9G15	0x00000000
+#define ARCH_EXID_AT91SAM9G35	0x00000001
+#define ARCH_EXID_AT91SAM9X35	0x00000002
+#define ARCH_EXID_AT91SAM9G25	0x00000003
+#define ARCH_EXID_AT91SAM9X25	0x00000004
+
 static inline unsigned long at91_exid_identify(void)
 {
 	return at91_sys_read(AT91_DBGU_EXID);
@@ -143,6 +150,27 @@ static inline unsigned long at91cap9_rev_identify(void)
 #define cpu_is_at91sam9m11()	(0)
 #endif
 
+#ifdef CONFIG_ARCH_AT91SAM9X5
+#define cpu_is_at91sam9x5()	(at91_cpu_identify() == ARCH_ID_AT91SAM9X5)
+#define cpu_is_at91sam9g15()	(cpu_is_at91sam9x5() && \
+				(at91_exid_identify() == ARCH_EXID_AT91SAM9G15))
+#define cpu_is_at91sam9g35()	(cpu_is_at91sam9x5() && \
+				(at91_exid_identify() == ARCH_EXID_AT91SAM9G35))
+#define cpu_is_at91sam9x35()	(cpu_is_at91sam9x5() && \
+				(at91_exid_identify() == ARCH_EXID_AT91SAM9X35))
+#define cpu_is_at91sam9g25()	(cpu_is_at91sam9x5() && \
+				(at91_exid_identify() == ARCH_EXID_AT91SAM9G25))
+#define cpu_is_at91sam9x25()	(cpu_is_at91sam9x5() && \
+				(at91_exid_identify() == ARCH_EXID_AT91SAM9X25))
+#else
+#define cpu_is_at91sam9x5()	(0)
+#define cpu_is_at91sam9g15()	(0)
+#define cpu_is_at91sam9g35()	(0)
+#define cpu_is_at91sam9x35()	(0)
+#define cpu_is_at91sam9g25()	(0)
+#define cpu_is_at91sam9x25()	(0)
+#endif
+
 #ifdef CONFIG_ARCH_AT91CAP9
 #define cpu_is_at91cap9()	(at91_cpu_identify() == ARCH_ID_AT91CAP9)
 #define cpu_is_at91cap9_revB()	(at91cap9_rev_identify() == ARCH_REVISION_CAP9_B)
-- 
1.7.4.1
