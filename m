From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  1 Jun 2016 22:06:37 +0300
Subject: [PATCH] ARM: nspire: Fix Kconfig dependency
Message-ID: <1464807997-3804-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

ARM926T-based machine should depend on the ARCH_MULTI_V5 option.
The ARCH_MULTI_V4_V5 is selected automatically by basic ARM configuration.

Signed-off-by: Alexander Shiyan <shc_work@mail.ru>
---
 arch/arm/mach-nspire/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-nspire/Kconfig b/arch/arm/mach-nspire/Kconfig
index bc41f26..a22e99c6 100644
--- a/arch/arm/mach-nspire/Kconfig
+++ b/arch/arm/mach-nspire/Kconfig
@@ -1,6 +1,6 @@
 config ARCH_NSPIRE
 	bool "TI-NSPIRE based"
-	depends on ARCH_MULTI_V4_V5
+	depends on ARCH_MULTI_V5
 	depends on MMU
 	select CPU_ARM926T
 	select GENERIC_IRQ_CHIP
-- 
2.4.9
