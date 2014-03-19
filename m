From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:02 +0100
Subject: [PATCH 05/62] ARM: at91: sama5 always uses DT
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It makes no sense for sama5 support to be enabled if we don't
also enable USE_OF. Making this automatic in Kconfig avoids
a possible randconfig conflict between the old and new clock
support code.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 7209c5b..5ec1da1 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -57,6 +57,7 @@ config SOC_SAMA5
 	select GENERIC_CLOCKEVENTS
 	select MULTI_IRQ_HANDLER
 	select SPARSE_IRQ
+	select USE_OF
 
 menu "Atmel AT91 System-on-Chip"
 
-- 
1.8.3.2
