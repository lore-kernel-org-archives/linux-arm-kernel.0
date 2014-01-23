From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu, 23 Jan 2014 16:57:09 +0100
Subject: [PATCH v3 05/15] ARM: at91: move sam9261 SoC to common clk
In-Reply-To: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
References: <1390492639-7299-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1390492639-7299-6-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch removes the selection of AT91_USE_OLD_CLK when selecting
sam9261 SoCs support. This will automatically enable COMMON_CLK_AT91 option
and add support for at91 common clk implementation.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/mach-at91/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index b4f7d6f..2214beb 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -120,7 +120,6 @@ config SOC_AT91SAM9261
 	select HAVE_AT91_DBGU0
 	select HAVE_FB_ATMEL
 	select SOC_AT91SAM9
-	select AT91_USE_OLD_CLK
 	select HAVE_AT91_USB_CLK
 	help
 	  Select this if you are using one of Atmel's AT91SAM9261 or AT91SAM9G10 SoC.
-- 
1.8.5.2
