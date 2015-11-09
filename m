From: yang.shi@linaro.org (Yang Shi)
Date: Mon,  9 Nov 2015 09:43:56 -0800
Subject: [PATCH 1/2] arm64: remove redundant FRAME_POINTER kconfig option
In-Reply-To: <1447091037-11434-1-git-send-email-yang.shi@linaro.org>
References: <1447091037-11434-1-git-send-email-yang.shi@linaro.org>
Message-ID: <1447091037-11434-2-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

FRAME_POINTER is defined in lib/Kconfig.debug, it is unnecessary to redefine
it in arch/arm64/Kconfig.debug. Actually, the one defined in arm64 directory
is never used.
This adds a dependency on DEBUG_KERNEL for building with frame pointers.

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
