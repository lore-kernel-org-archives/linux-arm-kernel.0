From: apinski@cavium.com (Andrew Pinski)
Date: Wed,  3 Sep 2014 14:18:56 -0700
Subject: [PATCH 02/24] ARM64: Rename COMPAT to AARCH32_EL0 in Kconfig
In-Reply-To: <1409779158-30963-1-git-send-email-apinski@cavium.com>
References: <1409779158-30963-1-git-send-email-apinski@cavium.com>
Message-ID: <1409779158-30963-3-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

We want to split CONFIG_COMPAT so we can use the COMPAT interface in some cases including
for compat binfmt.

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/Kconfig |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fd4e81a..73c93dd 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -375,9 +375,13 @@ menu "Userspace binary formats"
 source "fs/Kconfig.binfmt"
 
 config COMPAT
+	def_bool y
+	depends on AARCH32_EL0
+	select COMPAT_BINFMT_ELF
+
+config AARCH32_EL0
 	bool "Kernel support for 32-bit EL0"
 	depends on !ARM64_64K_PAGES
-	select COMPAT_BINFMT_ELF
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
 	select COMPAT_OLD_SIGACTION
@@ -391,7 +395,7 @@ config COMPAT
 
 config SYSVIPC_COMPAT
 	def_bool y
-	depends on COMPAT && SYSVIPC
+	depends on AARCH32_EL0 && SYSVIPC
 
 endmenu
 
-- 
1.7.2.5
