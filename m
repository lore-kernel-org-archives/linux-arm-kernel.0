From: keescook@chromium.org (Kees Cook)
Date: Wed, 6 Nov 2013 13:24:39 -0800
Subject: [PATCH v2] ARM: make OABI default to off
Message-ID: <20131106212439.GA24343@www.outflux.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Given recent discussions about the lack of OABI in the wild, switch
CONFIG_OABI_COMPAT to off-by-default to encourage more system builders
to avoid it.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
v2:
 - drop "default n", it is redundant; Olof Johansson
---
 arch/arm/Kconfig |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 1ad6fb6c094d..0a1dc697333c 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1728,7 +1728,6 @@ config AEABI
 config OABI_COMPAT
 	bool "Allow old ABI binaries to run with this kernel (EXPERIMENTAL)"
 	depends on AEABI && !THUMB2_KERNEL
-	default y
 	help
 	  This option preserves the old syscall interface along with the
 	  new (ARM EABI) one. It also provides a compatibility layer to
@@ -1740,7 +1739,7 @@ config OABI_COMPAT
 	  can say N here. If this option is not selected and you attempt
 	  to execute a legacy ABI binary then the result will be
 	  UNPREDICTABLE (in fact it can be predicted that it won't work
-	  at all). If in doubt say Y.
+	  at all). If in doubt say N.
 
 config ARCH_HAS_HOLES_MEMORYMODEL
 	bool
-- 
1.7.9.5


-- 
Kees Cook
Chrome OS Security
