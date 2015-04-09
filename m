From: gregory.0xf0@gmail.com (Gregory Fong)
Date: Wed,  8 Apr 2015 17:04:43 -0700
Subject: [RFC PATCH] ARM: debug: Add prompt for FRAME_POINTER to Kconfig.debug
Message-ID: <1428537883-19622-1-git-send-email-gregory.0xf0@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without a prompt string, it is impossible to disable FRAME_POINTER on
ARM. It will simply set the default value anytime you run 'make'.

To reproduce the original issue, run:
  make multi_v7_defconfig
  scripts/config -d ARM_UNWIND
  make oldconfig
  # check .config, note that FRAME_POINTER=y
  scripts/config -d FRAME_POINTER
  make oldconfig
  # check .config, note that FRAME_POINTER is still y

Signed-off-by: Gregory Fong <gregory.0xf0@gmail.com>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 970de75..b881fd3 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -33,7 +33,7 @@ config STRICT_DEVMEM
 # traces, you can get a slightly smaller kernel by setting this option to
 # n, but then RMK will have to kill you ;).
 config FRAME_POINTER
-	bool
+	bool "Compile the kernel with frame pointers"
 	depends on !THUMB2_KERNEL
 	default y if !ARM_UNWIND || FUNCTION_GRAPH_TRACER
 	help
-- 
1.9.1
