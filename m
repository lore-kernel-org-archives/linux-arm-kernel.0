From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 28 Aug 2013 10:42:05 +0900
Subject: [PATCH 5/5] ARM: shmobile: Introduce shmobile_boot_size
In-Reply-To: <cover.1377651075.git.horms+renesas@verge.net.au>
References: <cover.1377651075.git.horms+renesas@verge.net.au>
Message-ID: <c46a8cdf3e1ce9a79f58dca178da9e83138c0c01.1377651075.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Introduce shmobile_boot_size that can be used by
future SMP code to determine the size of the boot
code that needs to be copied to internal SRAM.

Signed-off-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/headsmp.S             | 3 +++
 arch/arm/mach-shmobile/include/mach/common.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index 2940fc9..743fa02 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -38,6 +38,9 @@ shmobile_boot_fn:
 	.globl	shmobile_boot_arg
 shmobile_boot_arg:
 2:	.space	4
+	.globl	shmobile_boot_size
+shmobile_boot_size:
+	.long	. - shmobile_boot_vector
 
 /*
  * Per-CPU SMP boot function/argument selection code based on MPIDR
diff --git a/arch/arm/mach-shmobile/include/mach/common.h b/arch/arm/mach-shmobile/include/mach/common.h
index 1ffe39c..fe2ea14 100644
--- a/arch/arm/mach-shmobile/include/mach/common.h
+++ b/arch/arm/mach-shmobile/include/mach/common.h
@@ -10,6 +10,7 @@ extern void shmobile_setup_console(void);
 extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_arg;
+extern unsigned long shmobile_boot_size;
 extern void shmobile_smp_boot(void);
 extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
-- 
1.8.3.2
