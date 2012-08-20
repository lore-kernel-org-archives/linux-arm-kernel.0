From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Mon, 20 Aug 2012 16:44:00 +0200
Subject: [PATCH] ARM: at91: automatically select DT support for sam9x5 and
 sam9n12
Message-ID: <1345473840-22141-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

at91sam9x5 and at91sam9n12 only have device tree support so we can
select device tree support when selecting these chips.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c8050b1..db94ec6 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -88,6 +88,7 @@ config SOC_AT91SAM9X5
 	select HAVE_AT91_DBGU0
 	select HAVE_FB_ATMEL
 	select HAVE_NET_MACB
+	select MACH_AT91SAM_DT
 	help
 	  Select this if you are using one of Atmel's AT91SAM9x5 family SoC.
 	  This means that your SAM9 name finishes with a '5' (except if it is
@@ -100,6 +101,7 @@ config SOC_AT91SAM9N12
 	select SOC_AT91SAM9
 	select HAVE_AT91_DBGU0
 	select HAVE_FB_ATMEL
+	select MACH_AT91SAM_DT
 	help
 	  Select this if you are using Atmel's AT91SAM9N12 SoC.
 
-- 
1.7.11.3
