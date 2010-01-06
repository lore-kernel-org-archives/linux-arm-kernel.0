From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed,  6 Jan 2010 10:31:51 -0800
Subject: [PATCH 09/35] davinci: explain CLOCK_TICK_RATE of 27MHz in
	include/mach/timex.h
In-Reply-To: <1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
References: <1262802737-6601-1-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-2-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-3-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-4-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-5-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-6-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-7-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-8-git-send-email-khilman@deeprootsystems.com>
	<1262802737-6601-9-git-send-email-khilman@deeprootsystems.com>
Message-ID: <1262802737-6601-10-git-send-email-khilman@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sekhar Nori <nsekhar@ti.com>

Leave a comment explaining the constant value of 27Mhz used
in include/mach/timex.h for all DaVinci platforms. Many of
the platforms actually run at 24MHz timer frequency (Eg.
EVMs of DM355, DM365 and OMAP-L1).

The comment also serves as a porting alert.

Signed-off-by: Sekhar Nori <nsekhar@ti.com>
Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>
---
 arch/arm/mach-davinci/include/mach/timex.h |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-davinci/include/mach/timex.h b/arch/arm/mach-davinci/include/mach/timex.h
index 5282756..9b88529 100644
--- a/arch/arm/mach-davinci/include/mach/timex.h
+++ b/arch/arm/mach-davinci/include/mach/timex.h
@@ -11,7 +11,12 @@
 #ifndef __ASM_ARCH_TIMEX_H
 #define __ASM_ARCH_TIMEX_H
 
-/* The source frequency for the timers is the 27MHz clock */
+/*
+ * Alert: Not all timers of the DaVinci family run at a frequency of 27MHz,
+ * but we should be fine as long as CLOCK_TICK_RATE or LATCH (see include/
+ * linux/jiffies.h) are not used directly in code. Currently none of the
+ * code relevant to DaVinci platform depends on these values directly.
+ */
 #define CLOCK_TICK_RATE 27000000
 
 #endif /* __ASM_ARCH_TIMEX_H__ */
-- 
1.6.6.rc2.1.g42108
