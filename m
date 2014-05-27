From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Tue, 27 May 2014 17:00:19 +0100
Subject: [PATCH v6 3/5] ARM: Hide DEBUG_LL_UART_NONE from unsupported platforms
In-Reply-To: <1401206421-29832-1-git-send-email-daniel.thompson@linaro.org>
References: <1400857819-7975-1-git-send-email-daniel.thompson@linaro.org>
 <1401206421-29832-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1401206421-29832-4-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only a small handful of platforms support DEBUG_LL_UART_NONE but it
lurks in the menus of every single platform config ready to break the
build. This is an especial problem for defconfigs since it is often
selected by default.

This patch limits this choice only to platforms which offer no other
means to use DEBUG_LL.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/Kconfig.debug | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index eab8ecb..33f0b38 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -842,7 +842,7 @@ choice
 
 	config DEBUG_LL_UART_NONE
 		bool "No low-level debugging UART"
-		depends on !ARCH_MULTIPLATFORM
+		depends on ARCH_KS8695 || ARCH_NETX || ARCH_OMAP1 || ARCH_SA1100
 		help
 		  Say Y here if your platform doesn't provide a UART option
 		  above. This relies on your platform choosing the right UART
-- 
1.9.0
