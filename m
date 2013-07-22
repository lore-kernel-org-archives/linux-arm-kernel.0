From: horms+renesas@verge.net.au (Simon Horman)
Date: Mon, 22 Jul 2013 16:37:01 +0900
Subject: [PATCH 4/5] ARM: shmobile: Insert align directives before 4 bytes data
In-Reply-To: <cover.1374478336.git.horms+renesas@verge.net.au>
References: <cover.1374478336.git.horms+renesas@verge.net.au>
Message-ID: <0b933cb305e7a987e0a711ee15457bd70055d682.1374478336.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Tetsuyuki Kobayashi <koba@kmckk.co.jp>

In thumb2 mode instructions are not align to 4 byte. This patch insert
align directives before putting 4 byte data.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/mach-shmobile/headsmp-scu.S  | 1 +
 arch/arm/mach-shmobile/headsmp.S      | 1 +
 arch/arm/mach-shmobile/sleep-sh7372.S | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/arch/arm/mach-shmobile/headsmp-scu.S b/arch/arm/mach-shmobile/headsmp-scu.S
index 5ce416c..0a77488 100644
--- a/arch/arm/mach-shmobile/headsmp-scu.S
+++ b/arch/arm/mach-shmobile/headsmp-scu.S
@@ -46,6 +46,7 @@ ENTRY(shmobile_boot_scu)
 ENDPROC(shmobile_boot_scu)
 
 	.text
+	.align	2
 	.globl	shmobile_scu_base
 shmobile_scu_base:
 	.space	4
diff --git a/arch/arm/mach-shmobile/headsmp.S b/arch/arm/mach-shmobile/headsmp.S
index afed58e..dfb41df 100644
--- a/arch/arm/mach-shmobile/headsmp.S
+++ b/arch/arm/mach-shmobile/headsmp.S
@@ -35,6 +35,7 @@ ENTRY(shmobile_boot_vector)
 
 ENDPROC(shmobile_boot_vector)
 
+	.align	2
 	.globl	shmobile_boot_fn
 shmobile_boot_fn:
 1:	.space	4
diff --git a/arch/arm/mach-shmobile/sleep-sh7372.S b/arch/arm/mach-shmobile/sleep-sh7372.S
index 53f4840..9782862 100644
--- a/arch/arm/mach-shmobile/sleep-sh7372.S
+++ b/arch/arm/mach-shmobile/sleep-sh7372.S
@@ -41,6 +41,7 @@
 sh7372_resume_core_standby_sysc:
 	ldr     pc, 1f
 
+	.align	2
 	.globl	sh7372_cpu_resume
 sh7372_cpu_resume:
 1:	.space	4
@@ -96,6 +97,7 @@ sh7372_do_idle_sysc:
 1:
 	b      1b
 
+	.align	2
 kernel_flush:
 	.word v7_flush_dcache_all
 #endif
-- 
1.8.2.1
