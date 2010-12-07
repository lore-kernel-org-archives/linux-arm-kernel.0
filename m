From: dave.martin@linaro.org (Dave Martin)
Date: Tue,  7 Dec 2010 16:57:37 +0000
Subject: [PATCH] ARM: Thumb-2: Make CONFIG_THUMB2_KERNEL depend on !CPU_V6
Message-ID: <1291741057-7449-1-git-send-email-dave.martin@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes sense, because Thumb-2 code can't execute on anything
prior to ARMv7.

This will avoid accidentally configuring a broken kernel where the
config otherwise would allow multiple architecture versions to
coexist in the same kernel.

Not adding !CPU_V5 etc., because the chance of anyone trying to
put v5 and v7 in the same kernel is low, and I'm not aware of
any mach which can do this.  These could be added later if it
matters.

Signed-off-by: Dave Martin <dave.martin@linaro.org>
---
KernelVersion: 2.6.37-rc4

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index f1d9297..bf1f8db 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1311,7 +1311,7 @@ config HZ
 
 config THUMB2_KERNEL
 	bool "Compile the kernel in Thumb-2 mode"
-	depends on CPU_V7 && EXPERIMENTAL
+	depends on CPU_V7 && !CPU_V6 && EXPERIMENTAL
 	select AEABI
 	select ARM_ASM_UNIFIED
 	help
-- 
1.7.1
