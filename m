From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:00 +0100
Subject: [PATCH 03/62] ARM: at91: export sam9_smc interfaces
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The pata_at91 driver uses interfaces defined in the sam9_smc
platform code. Since the pata driver can be a loadable module,
we have to export those symbols in order to link cleanly.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Andrew Victor <linux@maxim.org.za>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
Cc: Jean-Christophe Plagniol-Villard <plagnioj@jcrosoft.com>
---
 arch/arm/mach-at91/sam9_smc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/mach-at91/sam9_smc.c b/arch/arm/mach-at91/sam9_smc.c
index b26156b..826315a 100644
--- a/arch/arm/mach-at91/sam9_smc.c
+++ b/arch/arm/mach-at91/sam9_smc.c
@@ -36,6 +36,7 @@ void sam9_smc_write_mode(int id, int cs,
 {
 	sam9_smc_cs_write_mode(AT91_SMC_CS(id, cs), config);
 }
+EXPORT_SYMBOL_GPL(sam9_smc_write_mode);
 
 static void sam9_smc_cs_configure(void __iomem *base,
 					struct sam9_smc_config *config)
@@ -69,6 +70,7 @@ void sam9_smc_configure(int id, int cs,
 {
 	sam9_smc_cs_configure(AT91_SMC_CS(id, cs), config);
 }
+EXPORT_SYMBOL_GPL(sam9_smc_configure);
 
 static void sam9_smc_cs_read_mode(void __iomem *base,
 					struct sam9_smc_config *config)
@@ -84,6 +86,7 @@ void sam9_smc_read_mode(int id, int cs,
 {
 	sam9_smc_cs_read_mode(AT91_SMC_CS(id, cs), config);
 }
+EXPORT_SYMBOL_GPL(sam9_smc_read_mode);
 
 static void sam9_smc_cs_read(void __iomem *base,
 					struct sam9_smc_config *config)
-- 
1.8.3.2
