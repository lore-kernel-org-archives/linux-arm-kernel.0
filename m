From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu,  9 Jan 2014 13:31:41 +0100
Subject: [PATCH v2 04/12] at91: smc: export sam9_smc_cs_read and
 sam9_smc_cs_configure.
In-Reply-To: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
References: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1389270709-32662-5-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch makes sam9_smc_cs_read and sam9_smc_cs_configure available to
the rest of the kernel (though not to modules).

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/mach-at91/include/mach/at91sam9_smc.h | 2 ++
 arch/arm/mach-at91/sam9_smc.c                  | 4 ++--
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91sam9_smc.h b/arch/arm/mach-at91/include/mach/at91sam9_smc.h
index 175e1fd..56de08a 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9_smc.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9_smc.h
@@ -45,6 +45,8 @@ extern void sam9_smc_configure(int id, int cs, struct sam9_smc_config *config);
 extern void sam9_smc_read(int id, int cs, struct sam9_smc_config *config);
 extern void sam9_smc_read_mode(int id, int cs, struct sam9_smc_config *config);
 extern void sam9_smc_write_mode(int id, int cs, struct sam9_smc_config *config);
+extern void sam9_smc_cs_read(void __iomem *, struct sam9_smc_config *config);
+extern void sam9_smc_cs_configure(void __iomem *, struct sam9_smc_config *cfg);
 #endif
 
 #define AT91_SMC_SETUP		0x00				/* Setup Register for CS n */
diff --git a/arch/arm/mach-at91/sam9_smc.c b/arch/arm/mach-at91/sam9_smc.c
index b26156b..d7a6156 100644
--- a/arch/arm/mach-at91/sam9_smc.c
+++ b/arch/arm/mach-at91/sam9_smc.c
@@ -37,7 +37,7 @@ void sam9_smc_write_mode(int id, int cs,
 	sam9_smc_cs_write_mode(AT91_SMC_CS(id, cs), config);
 }
 
-static void sam9_smc_cs_configure(void __iomem *base,
+void sam9_smc_cs_configure(void __iomem *base,
 					struct sam9_smc_config *config)
 {
 
@@ -85,7 +85,7 @@ void sam9_smc_read_mode(int id, int cs,
 	sam9_smc_cs_read_mode(AT91_SMC_CS(id, cs), config);
 }
 
-static void sam9_smc_cs_read(void __iomem *base,
+void sam9_smc_cs_read(void __iomem *base,
 					struct sam9_smc_config *config)
 {
 	u32 val;
-- 
1.8.5.2
