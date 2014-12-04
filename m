From: agraf@suse.de (Alexander Graf)
Date: Thu,  4 Dec 2014 16:46:33 +0100
Subject: [PATCH] arm64: Enable CONFIG_COMPAT also for 64k page size
Message-ID: <1417707993-82290-1-git-send-email-agraf@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With binutils 2.25 the default alignment for 32bit arm sections changed to
have everything 64k aligned. Armv7 binaries built with this binutils version
run successfully on an arm64 system.

Since effectively there is now the chance to run armv7 code on arm64 even
with 64k page size, it doesn't make sense to block people from enabling
CONFIG_COMPAT on those configurations.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/arm64/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 9532f8d..3cf4f238 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -409,7 +409,6 @@ source "fs/Kconfig.binfmt"
 
 config COMPAT
 	bool "Kernel support for 32-bit EL0"
-	depends on !ARM64_64K_PAGES
 	select COMPAT_BINFMT_ELF
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
-- 
1.7.12.4
