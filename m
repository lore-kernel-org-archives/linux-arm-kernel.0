From: bilal.amarni@gmail.com (Bilal Amarni)
Date: Mon, 23 Jan 2017 18:03:12 +0100
Subject: [PATCH] ARM64: enable CONFIG_KEYS_COMPAT in Kconfig
Message-ID: <1485190992-86476-1-git-send-email-bilal.amarni@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently in 32-bit userspace calling the keyctl syscall returns an ENOSYS error.

This makes sure the compatibility wrapper is registered.

Signed-off-by: Bilal Amarni <bilal.amarni@gmail.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 1117421..d76f70b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1030,6 +1030,10 @@ config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
 
+config KEYS_COMPAT
+	def_bool y
+	depends on COMPAT && KEYS
+
 endmenu
 
 menu "Power management options"
-- 
2.7.2
