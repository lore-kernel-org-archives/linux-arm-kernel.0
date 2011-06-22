From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 16:12:54 +0100
Subject: [PATCH 13/25] ARM: pm: mach-s3c64xx: cleanup s3c_cpu_save
In-Reply-To: <20110622150816.GT23234@n2100.arm.linux.org.uk>
References: <20110622150816.GT23234@n2100.arm.linux.org.uk>
Message-ID: <E1QZP6s-0002Wb-Ta@rmk-PC.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

s3c_cpu_save does not need to save any registers with the new
cpu_suspend calling convention.  Remove these redundant instructions.

Acked-by: Frank Hofmann <frank.hofmann@tomtom.com>
Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 arch/arm/mach-s3c64xx/sleep.S |    4 +---
 1 files changed, 1 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-s3c64xx/sleep.S b/arch/arm/mach-s3c64xx/sleep.S
index dc4f582..2fd3433 100644
--- a/arch/arm/mach-s3c64xx/sleep.S
+++ b/arch/arm/mach-s3c64xx/sleep.S
@@ -35,10 +35,8 @@
 	*/
 
 ENTRY(s3c_cpu_save)
-	stmfd	sp!, { r4 - r12, lr }
 	adr	r3, BSYM(s3c64xx_finish_suspend)
-	bl	cpu_suspend
-	ldmfd	sp!, { r4 - r12, pc }
+	b	cpu_suspend
 
 s3c64xx_finish_suspend:
 	@@ call final suspend code
-- 
1.7.4.4
