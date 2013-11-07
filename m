From: will.deacon@arm.com (Will Deacon)
Date: Thu,  7 Nov 2013 19:02:11 +0000
Subject: [PATCH] ARM: kconfig: select GENERIC_CLOCKEVENTS if
 HAVE_ARM_ARCH_TIMER
Message-ID: <1383850931-15512-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The ARM architected timer driver doesn't compile without
GENERIC_CLOCKEVENTS selected, so ensure that we select it when building
for a platform that has the timer.

Without this patch, mach-virt fails to build without something like
mach-vexpress also selected.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 22700fda2047..bce493e8cb8f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1533,6 +1533,7 @@ config HAVE_ARM_ARCH_TIMER
 	bool "Architected timer support"
 	depends on CPU_V7
 	select ARM_ARCH_TIMER
+	select GENERIC_CLOCKEVENTS
 	help
 	  This option enables support for the ARM architected timer
 
-- 
1.8.2.2
