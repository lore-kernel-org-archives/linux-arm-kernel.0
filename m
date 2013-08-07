From: magnus.damm@gmail.com (Magnus Damm)
Date: Thu, 08 Aug 2013 07:14:07 +0900
Subject: [PATCH 05/05] ARM: shmobile: Introduce shmobile_boot_size
In-Reply-To: <20130807221321.22251.22774.sendpatchset@w520>
References: <20130807221321.22251.22774.sendpatchset@w520>
Message-ID: <20130807221407.22251.28821.sendpatchset@w520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Magnus Damm <damm@opensource.se>

Introduce shmobile_boot_size that can be used by
future SMP code to determine the size of the boot
code that needs to be copied to internal SRAM.

Signed-off-by: Magnus Damm <damm@opensource.se>
---

 arch/arm/mach-shmobile/headsmp.S             |    3 +++
 arch/arm/mach-shmobile/include/mach/common.h |    1 +
 2 files changed, 4 insertions(+)

--- 0001/arch/arm/mach-shmobile/headsmp.S
+++ work/arch/arm/mach-shmobile/headsmp.S	2013-08-07 19:11:46.000000000 +0900
@@ -40,6 +40,9 @@ shmobile_boot_fn:
 	.globl	shmobile_boot_arg
 shmobile_boot_arg:
 2:	.space	4
+	.globl	shmobile_boot_size
+shmobile_boot_size:
+	.long	. - shmobile_boot_vector
 
 /*
  * Per-CPU SMP boot function/argument selection code based on MPIDR
--- 0008/arch/arm/mach-shmobile/include/mach/common.h
+++ work/arch/arm/mach-shmobile/include/mach/common.h	2013-08-07 19:11:46.000000000 +0900
@@ -9,6 +9,7 @@ extern void shmobile_setup_console(void)
 extern void shmobile_boot_vector(void);
 extern unsigned long shmobile_boot_fn;
 extern unsigned long shmobile_boot_arg;
+extern unsigned long shmobile_boot_size;
 extern void shmobile_smp_boot(void);
 extern void shmobile_smp_sleep(void);
 extern void shmobile_smp_hook(unsigned int cpu, unsigned long fn,
