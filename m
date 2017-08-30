From: stefan.sorensen@spectralink.com (=?UTF-8?q?Stefan=20S=C3=B8rensen?=)
Date: Wed, 30 Aug 2017 09:03:34 +0200
Subject: [PATCH] arm: Drop ATAGS dependency for setting command line type
Message-ID: <20170830070334.4091-1-stefan.sorensen@spectralink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Setting CMDLINE_{FROM_BOOTLOADER,FORCE,EXTEND} on a build wihtout ATAGS is
both supported and useful, so remove the dependency on ATAGS.

Signed-off-by: Stefan S?rensen <stefan.sorensen@spectralink.com>
---
 arch/arm/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 61a0cb15067e..09ab43b889a0 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1951,7 +1951,6 @@ config CMDLINE
 choice
 	prompt "Kernel command line type" if CMDLINE != ""
 	default CMDLINE_FROM_BOOTLOADER
-	depends on ATAGS
 
 config CMDLINE_FROM_BOOTLOADER
 	bool "Use bootloader kernel arguments if available"
-- 
2.13.5
