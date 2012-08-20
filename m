From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Mon, 20 Aug 2012 17:40:26 +0200
Subject: [PATCH v2] ARM: at91: select DT support by default
Message-ID: <1345477226-23483-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Since at91sam9x5, at91sam9n12 and future SOCs only have device tree
support, select it by default.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index c8050b1..5aee940 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -502,6 +502,7 @@ comment "Generic Board Type"
 
 config MACH_AT91SAM_DT
 	bool "Atmel AT91SAM Evaluation Kits with device-tree support"
+	default y
 	select USE_OF
 	help
 	  Select this if you want to experiment device-tree with
-- 
1.7.11.3
