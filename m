From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 5 Aug 2013 14:11:11 -0400
Subject: [RESEND PATCH 4/7] ARM: keystone: Drop the un-necessary dsb from
 keystone_cpu_smc()
In-Reply-To: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
References: <1375726274-26000-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <1375726274-26000-5-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This was added because of some legacy reasons from OMAP SOCs but
after testing and verifying with the keystone hardware folks, the
dsb in keystone_cpu_smc() is not necessary.

So drop it.

Reported-by: Dave Martin <dave.martin@linaro.org>
Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
---
 arch/arm/mach-keystone/smc.S |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-keystone/smc.S b/arch/arm/mach-keystone/smc.S
index 5bb5176..d15de81 100644
--- a/arch/arm/mach-keystone/smc.S
+++ b/arch/arm/mach-keystone/smc.S
@@ -24,6 +24,5 @@
 ENTRY(keystone_cpu_smc)
 	stmfd   sp!, {r4-r11, lr}
 	smc	#0
-	dsb
 	ldmfd   sp!, {r4-r11, pc}
 ENDPROC(keystone_cpu_smc)
-- 
1.7.9.5
