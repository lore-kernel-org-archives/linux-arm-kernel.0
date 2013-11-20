From: taras.kondratiuk@linaro.org (Taras Kondratiuk)
Date: Wed, 20 Nov 2013 20:24:19 +0200
Subject: [PATCH] ARM: keystone: enable big endian support
Message-ID: <1384971859-7748-1-git-send-email-taras.kondratiuk@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Keystone code is big endian compatible,
so mark it as one that supports big endian.

Note this patch just allows to select Big endian build
for ARCH_KEYSTONE, but it does not enable BE by default.

Signed-off-by: Taras Kondratiuk <taras.kondratiuk@linaro.org>
---
Based on Linus' master tip (b4789b8).
Tested on Keystone2 EVM.

arch/arm/mach-keystone/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-keystone/Kconfig b/arch/arm/mach-keystone/Kconfig
index f20c53e..8a9e943 100644
--- a/arch/arm/mach-keystone/Kconfig
+++ b/arch/arm/mach-keystone/Kconfig
@@ -11,6 +11,7 @@ config ARCH_KEYSTONE
 	select ARM_ERRATA_798181 if SMP
 	select COMMON_CLK_KEYSTONE
 	select TI_EDMA
+	select ARCH_SUPPORTS_BIG_ENDIAN
 	help
 	  Support for boards based on the Texas Instruments Keystone family of
 	  SoCs.
-- 
1.7.9.5
