From: ynorov@caviumnetworks.com (Yury Norov)
Date: Tue, 24 May 2016 03:04:52 +0300
Subject: [PATCH 23/23] arm64:ilp32: add ARM64_ILP32 to Kconfig
In-Reply-To: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1464048292-30136-24-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

This patch adds the config option for ILP32.

Signed-off-by: Andrew Pinski <Andrew.Pinski@caviumnetworks.com>
Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
Reviewed-by: David Daney <ddaney@caviumnetworks.com>
---
 arch/arm64/Kconfig | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 0bb7adc..765d7c2 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -926,12 +926,13 @@ source "fs/Kconfig.binfmt"
 
 config COMPAT
 	bool
-	depends on AARCH32_EL0
+	depends on AARCH32_EL0 || ARM64_ILP32
 
 config AARCH32_EL0
 	bool "Kernel support for 32-bit EL0"
 	def_bool y
 	depends on ARM64_4K_PAGES || EXPERT
+	select COMPAT
 	select HAVE_UID16
 	select OLD_SIGSUSPEND3
 	select COMPAT_OLD_SIGACTION
@@ -947,6 +948,15 @@ config AARCH32_EL0
 
 	  If you want to execute 32-bit userspace applications, say Y.
 
+config ARM64_ILP32
+	bool "Kernel support for ILP32"
+	select COMPAT
+	select COMPAT_WRAPPER
+	help
+	  This option enables support for AArch64 ILP32 user space.  ILP32
+	  is an ABI where long and pointers are 32bits but it uses the AARCH64
+	  instruction set.
+
 config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
-- 
2.5.0
