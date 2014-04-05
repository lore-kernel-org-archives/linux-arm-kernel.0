From: lauraa@codeaurora.org (Laura Abbott)
Date: Fri,  4 Apr 2014 17:30:50 -0700
Subject: [PATCH] arm64: Add missing Kconfig for CONFIG_STRICT_DEVMEM
Message-ID: <1396657850-14252-1-git-send-email-lauraa@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Kconfig for CONFIG_STRICT_DEVMEM is missing despite being
used in mmap.c. Add it.

Signed-off-by: Laura Abbott <lauraa@codeaurora.org>
---
 arch/arm64/Kconfig.debug | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/arm64/Kconfig.debug b/arch/arm64/Kconfig.debug
index 835c559..4be4336 100644
--- a/arch/arm64/Kconfig.debug
+++ b/arch/arm64/Kconfig.debug
@@ -6,6 +6,20 @@ config FRAME_POINTER
 	bool
 	default y
 
+config STRICT_DEVMEM
+	bool "Filter access to /dev/mem"
+	depends on MMU
+        help
+	  If this option is disabled, you allow userspace (root) access to all
+	  of memory, including kernel and userspace memory. Accidental
+	  access to this is obviously disastrous, but specific access can
+	  be used by people debugging the kernel.
+
+	  If this option is switched on, the /dev/mem file only allows
+	  userspace access to memory mapped peripherals.
+
+	  If in doubt, say Y.
+
 config EARLY_PRINTK
 	bool "Early printk support"
 	default y
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
