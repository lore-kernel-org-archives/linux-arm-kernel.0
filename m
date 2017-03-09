From: ebiggers3@gmail.com (Eric Biggers)
Date: Wed,  8 Mar 2017 16:27:04 -0800
Subject: [PATCH] arm64: support keyctl() system call in 32-bit mode
Message-ID: <20170309002704.68115-1-ebiggers3@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Eric Biggers <ebiggers@google.com>

As is the case for a number of other architectures that have a 32-bit
compat mode, enable KEYS_COMPAT if both COMPAT and KEYS are enabled.
This allows AArch32 programs to use the keyctl() system call when
running on an AArch64 kernel.

Signed-off-by: Eric Biggers <ebiggers@google.com>
---
 arch/arm64/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index a39029b5414e..f21e9a76ff67 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -1063,6 +1063,10 @@ config SYSVIPC_COMPAT
 	def_bool y
 	depends on COMPAT && SYSVIPC
 
+config KEYS_COMPAT
+	def_bool y
+	depends on COMPAT && KEYS
+
 endmenu
 
 menu "Power management options"
-- 
2.12.0.246.ga2ecc84866-goog
