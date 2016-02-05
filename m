From: yang.shi@linaro.org (Yang Shi)
Date: Fri,  5 Feb 2016 15:50:18 -0800
Subject: [PATCH] arm64: ubsan: select ARCH_HAS_UBSAN_SANITIZE_ALL
Message-ID: <1454716218-4918-1-git-send-email-yang.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To enable UBSAN on arm64, ARCH_HAS_UBSAN_SANITIZE_ALL need to be selected.

Basic kernel bootup test is passed on arm64 with CONFIG_UBSAN_SANITIZE_ALL
enabled.

Signed-off-by: Yang Shi <yang.shi@linaro.org>
---
 arch/arm64/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 8cc6228..1c29e20 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -14,6 +14,7 @@ config ARM64
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION
 	select ARCH_WANT_FRAME_POINTERS
+	select ARCH_HAS_UBSAN_SANITIZE_ALL
 	select ARM_AMBA
 	select ARM_ARCH_TIMER
 	select ARM_GIC
-- 
2.0.2
