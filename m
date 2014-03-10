From: olof@lixom.net (Olof Johansson)
Date: Sun,  9 Mar 2014 22:42:09 -0700
Subject: [PATCH] ARM: enable ARM_HAS_SG_CHAIN for multiplatform
Message-ID: <1394430129-30297-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable ARM_HAS_SG_CHAIN for all multiplatform targets, it makes sense
to enable on all "modern" platforms; downsides are limited for platforms
that don't need it.

Requested-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Olof Johansson <olof@lixom.net>
---

I'll apply this to next/soc in lack of better places. I did a build+boot
test across my set of machines earlier today and it didn't seem to cause
any problems.

 arch/arm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index a5833f792e56..271a54d5d26f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -307,6 +307,7 @@ config ARCH_MULTIPLATFORM
 	bool "Allow multiple platforms to be selected"
 	depends on MMU
 	select ARCH_WANT_OPTIONAL_GPIOLIB
+	select ARM_HAS_SG_CHAIN
 	select ARM_PATCH_PHYS_VIRT
 	select AUTO_ZRELADDR
 	select CLKSRC_OF
-- 
1.8.4.1.601.g02b3b1d
