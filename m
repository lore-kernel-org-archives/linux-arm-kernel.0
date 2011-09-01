From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 01 Sep 2011 13:48:58 +0100
Subject: [PATCH 02/11] ARM: pm: arm920/926: fix number of registers saved
In-Reply-To: <20110901124752.GE29729@n2100.arm.linux.org.uk>
References: <20110901124752.GE29729@n2100.arm.linux.org.uk>
Message-ID: <E1Qz6hW-00078F-VZ@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM920 and ARM926 save four registers, not three.  Fix the size of
the suspend region required.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mm/proc-arm920.S |    2 +-
 arch/arm/mm/proc-arm926.S |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mm/proc-arm920.S b/arch/arm/mm/proc-arm920.S
index 92bd102..2e6849b 100644
--- a/arch/arm/mm/proc-arm920.S
+++ b/arch/arm/mm/proc-arm920.S
@@ -379,7 +379,7 @@ ENTRY(cpu_arm920_set_pte_ext)
 
 /* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S */
 .globl	cpu_arm920_suspend_size
-.equ	cpu_arm920_suspend_size, 4 * 3
+.equ	cpu_arm920_suspend_size, 4 * 4
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_arm920_do_suspend)
 	stmfd	sp!, {r4 - r7, lr}
diff --git a/arch/arm/mm/proc-arm926.S b/arch/arm/mm/proc-arm926.S
index 2bbcf05..cd8f79c 100644
--- a/arch/arm/mm/proc-arm926.S
+++ b/arch/arm/mm/proc-arm926.S
@@ -394,7 +394,7 @@ ENTRY(cpu_arm926_set_pte_ext)
 
 /* Suspend/resume support: taken from arch/arm/plat-s3c24xx/sleep.S */
 .globl	cpu_arm926_suspend_size
-.equ	cpu_arm926_suspend_size, 4 * 3
+.equ	cpu_arm926_suspend_size, 4 * 4
 #ifdef CONFIG_PM_SLEEP
 ENTRY(cpu_arm926_do_suspend)
 	stmfd	sp!, {r4 - r7, lr}
-- 
1.7.4.4
