From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 15 Sep 2014 23:09:46 +0100
Subject: [PATCH] arm: Remove redundant config value DEBUG_UART_NETX
Message-ID: <1410818986-13273-1-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 880fa9b6fd73 ("ARM: 8144/1: netx: Migrate DEBUG_LL macros to
shared directory") spuriously introduces an unused config variable,
DEBUG_UART_NETX. Let's remove it.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 arch/arm/Kconfig.debug | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 537dd04..b6ec25a 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -450,7 +450,6 @@ choice
 	config DEBUG_NETX_UART
 		bool "Kernel low-level debugging messages via NetX UART"
 		depends on ARCH_NETX
-		select DEBUG_UART_NETX
 		help
 		  Say Y here if you want kernel low-level debugging support
 		  on Hilscher NetX based platforms.
-- 
1.9.3
