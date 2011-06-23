From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Jun 2011 20:14:06 +0100
Subject: [PATCH 15/25] ARM: pm: mach-s5pv210: cleanup s3c_cpu_save
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Message-ID: <E1QZpLq-0005mr-Hg@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c_cpu_save does not need to save any registers with the new
cpu_suspend calling convention.  Remove these redundant instructions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-s5pv210/sleep.S |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-s5pv210/sleep.S b/arch/arm/mach-s5pv210/sleep.S
index 1182fc8..28dfeff 100644
--- a/arch/arm/mach-s5pv210/sleep.S
+++ b/arch/arm/mach-s5pv210/sleep.S
@@ -39,11 +39,8 @@
 	*/
 
 ENTRY(s3c_cpu_save)
-
-	stmfd	sp!, { r3 - r12, lr }
 	adr	r3, BSYM(s5pv210_finish_suspend)
-	bl	cpu_suspend
-	ldmfd	sp!, { r3 - r12, pc }
+	b	cpu_suspend
 
 s5pv210_finish_suspend:
 	ldr	r0, =pm_cpu_sleep
-- 
1.7.4.4
