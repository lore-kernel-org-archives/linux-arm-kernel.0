From: apinski@cavium.com (Andrew Pinski)
Date: Sat, 24 May 2014 00:02:06 -0700
Subject: [PATCH 11/24] ARM64: Add ARM64_ILP32 to Kconfig.
In-Reply-To: <1400914939-9708-1-git-send-email-apinski@cavium.com>
References: <1400914939-9708-1-git-send-email-apinski@cavium.com>
Message-ID: <1400914939-9708-12-git-send-email-apinski@cavium.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch adds the config option for ILP32.

Thanks,
Andrew Pinski

Signed-off-by: Andrew Pinski <apinski@cavium.com>
---
 arch/arm64/Kconfig |    9 ++++++++-
 1 files changed, 8 insertions(+), 1 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 032c712..92577da 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -288,7 +288,7 @@ source "fs/Kconfig.binfmt"
 
 config COMPAT
 	def_bool y
-	depends on AARCH32_EL0
+	depends on AARCH32_EL0 || ARM64_ILP32
 	select COMPAT_BINFMT_ELF
 
 config AARCH32_EL0
@@ -305,6 +305,13 @@ config AARCH32_EL0
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config ARM64_ILP32
+	bool "Kernel support for ILP32"
+	help
+	  This option enables support for AArch64 ILP32 user space.  ILP32
+	  is an ABI where long and pointers are 32bits but it uses the AARCH64
+	  instruction set.
+
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on AARCH32_EL0 && SYSVIPC
-- 
1.7.2.5
