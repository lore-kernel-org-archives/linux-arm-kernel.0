From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Thu,  9 Jan 2014 13:31:42 +0100
Subject: [PATCH v2 05/12] at91: smc: Increased the size of tdf_cycles in
 struct sam9_smc_config.
In-Reply-To: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
References: <1389270709-32662-1-git-send-email-jjhiblot@traphandler.com>
Message-ID: <1389270709-32662-6-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This makes it possible to check if the tdf_cycle is too big to fit in the
register.

Signed-off-by: Jean-Jacques Hiblot <jjhiblot@traphandler.com>
---
 arch/arm/mach-at91/include/mach/at91sam9_smc.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/mach-at91/include/mach/at91sam9_smc.h b/arch/arm/mach-at91/include/mach/at91sam9_smc.h
index 56de08a..c3e29311 100644
--- a/arch/arm/mach-at91/include/mach/at91sam9_smc.h
+++ b/arch/arm/mach-at91/include/mach/at91sam9_smc.h
@@ -38,7 +38,7 @@ struct sam9_smc_config {
 
 	/* Mode register */
 	u32 mode;
-	u8 tdf_cycles:4;
+	u8 tdf_cycles;
 };
 
 extern void sam9_smc_configure(int id, int cs, struct sam9_smc_config *config);
-- 
1.8.5.2
