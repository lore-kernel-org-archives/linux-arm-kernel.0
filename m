From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 13 Jun 2011 18:17:53 +0100
Subject: [PATCH 09/14] ARM: suspend: plat-s3c24xx: cleanup s3c_cpu_save
In-Reply-To: <20110613171446.GF13643@n2100.arm.linux.org.uk>
References: <20110613171446.GF13643@n2100.arm.linux.org.uk>
Message-ID: <E1QWAlt-0002eG-G8@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c_cpu_save does not need to save any registers with the new
cpu_suspend calling convention.  Remove these redundant instructions.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/plat-s3c24xx/sleep.S |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/plat-s3c24xx/sleep.S b/arch/arm/plat-s3c24xx/sleep.S
index f822e62..6ada459 100644
--- a/arch/arm/plat-s3c24xx/sleep.S
+++ b/arch/arm/plat-s3c24xx/sleep.S
@@ -48,10 +48,8 @@
 	*/
 
 ENTRY(s3c_cpu_save)
-	stmfd	sp!, { r4 - r12, lr }
 	adr	r3, BSYM(s3c24xx_finish_suspend)
-	bl	cpu_suspend
-	ldmfd	sp!, { r4 - r12, pc }
+	b	cpu_suspend
 
 s3c24xx_finish_suspend:
 	@@ jump to final code to send system to sleep
-- 
1.7.4.4
