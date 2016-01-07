From: ynorov@caviumnetworks.com (Yury Norov)
Date: Fri, 8 Jan 2016 02:34:39 +0300
Subject: [PATCH v6 21/21] arm64:ilp32: add ARM64_ILP32 to Kconfig
In-Reply-To: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
References: <1452209679-19445-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1452209679-19445-22-git-send-email-ynorov@caviumnetworks.com>
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
 arch/arm64/Kconfig | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 2c205a4..8606c15 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -763,7 +763,7 @@ source "fs/Kconfig.binfmt"
 
 config COMPAT
 	def_bool y
-	depends on AARCH32_EL0
+	depends on AARCH32_EL0 || ARM64_ILP32
 
 config AARCH32_EL0
 	bool "Kernel support for 32-bit EL0"
@@ -783,6 +783,13 @@ config AARCH32_EL0
 
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
 	depends on COMPAT && SYSVIPC
-- 
2.5.0
