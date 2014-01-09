From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu,  9 Jan 2014 12:49:47 +0100
Subject: [PATCH] at91: smc: bug fix in sam9_smc_cs_read()
Message-ID: <1389268187-23585-1-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There was a copy/paste error when reading the nwe_pulse value.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/mach-at91/sam9_smc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/sam9_smc.c b/arch/arm/mach-at91/sam9_smc.c
index 99a0a1d..b26156b 100644
--- a/arch/arm/mach-at91/sam9_smc.c
+++ b/arch/arm/mach-at91/sam9_smc.c
@@ -101,7 +101,7 @@ static void sam9_smc_cs_read(void __iomem *base,
 	/* Pulse register */
 	val = __raw_readl(base + AT91_SMC_PULSE);
 
-	config->nwe_setup = val & AT91_SMC_NWEPULSE;
+	config->nwe_pulse = val & AT91_SMC_NWEPULSE;
 	config->ncs_write_pulse = (val & AT91_SMC_NCS_WRPULSE) >> 8;
 	config->nrd_pulse = (val & AT91_SMC_NRDPULSE) >> 16;
 	config->ncs_read_pulse = (val & AT91_SMC_NCS_RDPULSE) >> 24;
-- 
1.8.5.2
