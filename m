From: daniel.thompson@linaro.org (Daniel Thompson)
Date: Mon,  5 Jan 2015 12:40:19 +0000
Subject: [PATCH 3.19-rc2 v15 3/8] arm: Remove DEBUG_LL_UART_NONE
In-Reply-To: <1420461624-4410-1-git-send-email-daniel.thompson@linaro.org>
References: <1420461624-4410-1-git-send-email-daniel.thompson@linaro.org>
Message-ID: <1420461624-4410-4-git-send-email-daniel.thompson@linaro.org>
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
index c5648cc1466d..6ee9b0d361ee 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -1031,15 +1031,6 @@ choice
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
