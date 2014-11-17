From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon, 17 Nov 2014 14:49:04 +0000
Subject: [PATCH v13 3/9] arm: Remove DEBUG_LL_UART_NONE
In-Reply-To: <1416235750-4766-1-git-send-email-daniel.thompson@linaro.org>
References: <1416235750-4766-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1416235750-4766-4-git-send-email-daniel.thompson@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Only a very small handful of platforms support DEBUG_LL_UART_NONE but it
lurks in the menus of every single platform config ready to break the
build. This is an especial problem for defconfig/oldconfig since it is
often selected by default.

This patch solves the problem by removing this option. Any platforms
still depending upon this option must be migrated.

Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
Cc: Russell King <linux@arm.linux.org.uk>
---
 arch/arm/Kconfig.debug | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index c1a5fa3ec0a7..1316c2b9a222 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -909,15 +909,6 @@ choice
 		  This option selects UART0 on VIA/Wondermedia System-on-a-chip
 		  devices, including VT8500, WM8505, WM8650 and WM8850.
 
-	config DEBUG_LL_UART_NONE
-		bool "No low-level debugging UART"
-		depends on !ARCH_MULTIPLATFORM
-		help
-		  Say Y here if your platform doesn't provide a UART option
-		  above. This relies on your platform choosing the right UART
-		  definition internally in order for low-level debugging to
-		  work.
-
 	config DEBUG_ICEDCC
 		bool "Kernel low-level debugging via EmbeddedICE DCC channel"
 		help
-- 
1.9.3
