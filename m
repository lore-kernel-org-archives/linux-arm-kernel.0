From: will.deacon@arm.com (Will Deacon)
Date: Thu, 10 Jun 2010 15:59:57 +0100
Subject: [PATCH 4/4] ARM: hw-breakpoint: add HAVE_HW_BREAKPOINT to Kconfig
In-Reply-To: <1276181997-20677-4-git-send-email-will.deacon@arm.com>
References: <1276181997-20677-1-git-send-email-will.deacon@arm.com>
	<1276181997-20677-2-git-send-email-will.deacon@arm.com>
	<1276181997-20677-3-git-send-email-will.deacon@arm.com>
	<1276181997-20677-4-git-send-email-will.deacon@arm.com>
Message-ID: <1276181997-20677-5-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

If we're targetting a v6 or v7 core and have at least software perf events
available, then automatically add support for hardware breakpoints.

Cc: Frederic Weisbecker <fweisbec@gmail.com>
Cc: S. Karthikeyan <informkarthik@gmail.com>
Signed-off-by: Will Deacon <will.deacon@arm.com>
---
 arch/arm/Kconfig         |    1 +
 arch/arm/kernel/Makefile |    1 +
 2 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index e57cb24..7ed4d58 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -24,6 +24,7 @@ config ARM
 	select HAVE_KERNEL_LZMA
 	select HAVE_PERF_EVENTS
 	select PERF_USE_VMALLOC
+	select HAVE_HW_BREAKPOINT if (PERF_EVENTS && (CPU_V6 || CPU_V7))
 	help
 	  The ARM series is a line of low-power-consumption RISC chip designs
 	  licensed by ARM Ltd and targeted at embedded applications and
diff --git a/arch/arm/kernel/Makefile b/arch/arm/kernel/Makefile
index 26d302c..e679fb0 100644
--- a/arch/arm/kernel/Makefile
+++ b/arch/arm/kernel/Makefile
@@ -39,6 +39,7 @@ obj-$(CONFIG_ARM_THUMBEE)	+= thumbee.o
 obj-$(CONFIG_KGDB)		+= kgdb.o
 obj-$(CONFIG_ARM_UNWIND)	+= unwind.o
 obj-$(CONFIG_HAVE_TCM)		+= tcm.o
+obj-$(CONFIG_HAVE_HW_BREAKPOINT)	+= hw_breakpoint.o
 
 obj-$(CONFIG_CRUNCH)		+= crunch.o crunch-bits.o
 AFLAGS_crunch-bits.o		:= -Wa,-mcpu=ep9312
-- 
1.6.3.3
