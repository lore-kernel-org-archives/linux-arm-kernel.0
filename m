From: will.deacon@arm.com (Will Deacon)
Date: Tue,  2 Feb 2010 16:22:28 +0000
Subject: [RFC PATCH 4/4] ARM: hw-breakpoint: add HAVE_HW_BREAKPOINT to Kconfig
In-Reply-To: <1265127748-4587-4-git-send-email-will.deacon@arm.com>
References: <1265127748-4587-1-git-send-email-will.deacon@arm.com>
	<1265127748-4587-2-git-send-email-will.deacon@arm.com>
	<1265127748-4587-3-git-send-email-will.deacon@arm.com>
	<1265127748-4587-4-git-send-email-will.deacon@arm.com>
Message-ID: <1265127748-4587-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we're targetting a v6 or v7 core and have at least software perf events
available, then automatically add support for hardware breakpoints.

Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig         |    1 +
 arch/arm/kernel/Makefile |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 195722a..361f546 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -23,6 +23,7 @@ config ARM
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
 	select GENERIC_ATOMIC64 if (!CPU_32v6K)
+	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V7))
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index c76e6d2..a06c8cc 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 
 obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
 AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
-- 
1.6.5.7
