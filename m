From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 14 Mar 2012 13:00:56 -0700
Subject: [PATCH] ARM: Kconfig: Remove duplicate IRQ Kconfig entries
Message-ID: <1331755256-31163-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These kconfig entries are already defined in kernel/irq/Kconfig
so select them instead of redefining them.

Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
---
 arch/arm/Kconfig |   10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 7a08e37..a3ae6e9 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -30,6 +30,8 @@ config ARM
 	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V6K || CPU_V7))
 	select HAVE_C_RECORDMCOUNT
 	select HAVE_GENERIC_HARDIRQS
+	select HARDIRQS_SW_RESEND
+	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select CPU_PM if (SUSPEND || CPU_IDLE)
 	select GENERIC_PCI_IOMAP
@@ -125,14 +127,6 @@ config TRACE_IRQFLAGS_SUPPORT
 	bool
 	default y
 
-config HARDIRQS_SW_RESEND
-	bool
-	default y
-
-config GENERIC_IRQ_PROBE
-	bool
-	default y
-
 config GENERIC_LOCKBREAK
 	bool
 	default y
-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
