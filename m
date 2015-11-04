From: yang.shi@linaro.org (Yang Shi)
Date: Wed,  4 Nov 2015 09:37:51 -0800
Subject: [PATCH] arm64: remove redundant FRAME_POINTER kconfig option
Message-ID: <1446658671-16238-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FRAME_POINTER is defined in lib/Kconfig.debug, it is unnecessary to redefine
it in arch/arm64/Kconfig.debug.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/arm64/Kconfig.debug | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index d6285ef..915dea7 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -2,10 +2,6 @@ menu "Kernel hacking"
 
 source "lib/Kconfig.debug"
 
-config FRAME_POINTER
-	bool
-	default y
-
 config ARM64_PTDUMP
 	bool "Export kernel pagetable layout to userspace via debugfs"
 	depends on DEBUG_KERNEL
-- 
2.0.2
