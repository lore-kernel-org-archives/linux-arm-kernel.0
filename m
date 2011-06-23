From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Jun 2011 20:14:26 +0100
Subject: [PATCH 16/25] ARM: pm: mach-exynos4: cleanup s3c_cpu_save
In-Reply-To: <20110623190900.GH9449@n2100.arm.linux.org.uk>
References: <20110623190900.GH9449@n2100.arm.linux.org.uk>
Message-ID: <E1QZpMA-0005mv-LA@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c_cpu_save does not need to save any registers with the new
cpu_suspend calling convention.  Remove these redundant instructions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-exynos4/sleep.S |    5 +----
 1 files changed, 1 insertions(+), 4 deletions(-)

diff --git a/arch/arm/mach-exynos4/sleep.S b/arch/arm/mach-exynos4/sleep.S
index d9a2287..b56a491 100644
--- a/arch/arm/mach-exynos4/sleep.S
+++ b/arch/arm/mach-exynos4/sleep.S
@@ -40,11 +40,8 @@
 	 */
 
 ENTRY(s3c_cpu_save)
-
-	stmfd	sp!, { r3 - r12, lr }
 	adr	r3, BSYM(exynos4_finish_suspend)
-	bl	cpu_suspend
-	ldmfd	sp!, { r3 - r12, pc }
+	b	cpu_suspend
 
 exynos4_finish_suspend:
 	ldr	r0, =pm_cpu_sleep
-- 
1.7.4.4
