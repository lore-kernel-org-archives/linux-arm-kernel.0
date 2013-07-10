From: koba@kmckk.co.jp (Tetsuyuki Kobayashi)
Date: Wed, 10 Jul 2013 10:56:37 +0900
Subject: [PATCH 3/3] ARM: shmobile: Insert align directives before 4 bytes data
In-Reply-To: <1373421397-1786-1-git-send-email-koba@kmckk.co.jp>
References: <1373421397-1786-1-git-send-email-koba@kmckk.co.jp>
Message-ID: <1373421397-1786-4-git-send-email-koba@kmckk.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In thumb2 mode instructions are not align to 4 byte. This patch insert
align directives before putting 4 byte data.

Signed-off-by: Tetsuyuki Kobayashi <koba@kmckk.co.jp>
---
 arch/arm/mach-shmobile/headsmp-scu.S  |    1 +
 arch/arm/mach-shmobile/headsmp.S      |    1 +
 arch/arm/mach-shmobile/sleep-sh7372.S |    2 ++
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
1.7.9.5
