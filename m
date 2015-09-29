From: ynorov@caviumnetworks.com (Yury Norov)
Date: Wed, 30 Sep 2015 01:14:00 +0300
Subject: [PATCH v5 03/23] arm64: rename COMPAT to AARCH32_EL0 in Kconfig
In-Reply-To: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
References: <1443564860-31208-1-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <1443564860-31208-4-git-send-email-ynorov@caviumnetworks.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Pinski <apinski@cavium.com>

Signed-off-by: Philipp Tomsich <philipp.tomsich@theobroma-systems.com>
Signed-off-by: Christoph Muellner <christoph.muellner@theobroma-systems.com>
Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 07d1811..d1dc605 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -679,6 +679,11 @@ menu "Userspace binary formats"
 source "fs/Kconfig.binfmt"
 
 config COMPAT
+	def_bool y
+	depends on AARCH32_EL0
+	select COMPAT_BINFMT_ELF
+
+config AARCH32_EL0
 	bool "Kernel support for 32-bit EL0"
 	depends on !ARM64_64K_PAGES || EXPERT
 	select COMPAT_BINFMT_ELF
@@ -699,7 +704,7 @@ config COMPAT
 
 config SYSVIPC_COMPAT
 	def_bool y
-	depends on COMPAT && SYSVIPC
+	depends on AARCH32_EL0 && SYSVIPC
 
 endmenu
 
-- 
2.1.4
