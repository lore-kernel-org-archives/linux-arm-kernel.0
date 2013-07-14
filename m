From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 14 Jul 2013 12:38:05 +0200
Subject: [PATCH] ARM: keystone: drop "select HAVE_SCHED_CLOCK"
Message-ID: <1373798285.1370.2.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig symbol HAVE_SCHED_CLOCK got removed in v3.4,
with commit 6905a65879b5 ("ARM: Make the sched_clock
framework mandatory"). But a select statement for it popped up again
through commit 828989ad87af ("ARM: keystone: Add minimal TI Keystone
platform support"). Drop that statement, as it is useless.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Not tested.

 arch/arm/mach-keystone/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index 51a50e9..366d1a3 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -7,7 +7,6 @@ config ARCH_KEYSTONE
 	select HAVE_SMP
 	select CLKSRC_MMIO
 	select GENERIC_CLOCKEVENTS
-	select HAVE_SCHED_CLOCK
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_ERRATA_798181 if SMP
 	help
-- 
1.8.1.4
