From: chanho.min@lge.com (Chanho Min)
Date: Tue, 15 Apr 2014 10:28:00 +0900
Subject: [PATCH] arm64:kconfig: Add default line for CONFIG_COMPAT
Message-ID: <1397525280-21844-1-git-send-email-chanho.min@lge.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Correct minimal config is not generated without default line.
'default n' should be added to set COMPAT to 'n'. Otherwise,
Enabling COMPAT is not reflected to minial config.

Signed-off-by: Chanho Min <chanho.min@lge.com>
---
 arch/arm64/Kconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e6e4d37..b891543 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -288,6 +288,7 @@ source "fs/Kconfig.binfmt"
 
 config COMPAT
 	bool "Kernel support for 32-bit EL0"
+	default n
 	depends on !ARM64_64K_PAGES
 	select COMPAT_BINFMT_ELF
 	select HAVE_UID16
-- 
1.7.9.5
