From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 14:11:10 -0400
Subject: [RESEND PATCH 3/7] ARM: Keystone: No need to preserve r12 across smc
 call
In-Reply-To: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375726274-26000-4-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Register r12 is caller-save, so no need preserve it keystone_cpu_smc().

Reported-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/smc.S |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-keystone/smc.S b/arch/arm/mach-keystone/smc.S
index 9b9e4f7..5bb5176 100644
--- a/arch/arm/mach-keystone/smc.S
+++ b/arch/arm/mach-keystone/smc.S
@@ -22,8 +22,8 @@
  * Return: Non zero value on failure
  */
 ENTRY(keystone_cpu_smc)
-	stmfd   sp!, {r4-r12, lr}
+	stmfd   sp!, {r4-r11, lr}
 	smc	#0
 	dsb
-	ldmfd   sp!, {r4-r12, pc}
+	ldmfd   sp!, {r4-r11, pc}
 ENDPROC(keystone_cpu_smc)
-- 
1.7.9.5
