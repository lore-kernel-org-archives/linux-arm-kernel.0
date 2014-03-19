From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Mar 2014 20:29:16 +0100
Subject: [PATCH 19/62] ARM: lpc32xx: export lpc32xx_return_iram_size
In-Reply-To: <1395257399-359545-1-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
Message-ID: <1395257399-359545-20-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This symbol is used by the lpc_eth driver, which may
be a loadable module.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Roland Stigge <stigge@antcom.de>
---
 arch/arm/mach-lpc32xx/common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-lpc32xx/common.c b/arch/arm/mach-lpc32xx/common.c
index d7aa54c..de03620 100644
--- a/arch/arm/mach-lpc32xx/common.c
+++ b/arch/arm/mach-lpc32xx/common.c
@@ -99,6 +99,7 @@ u32 lpc32xx_return_iram_size(void)
 
 	return iram_size;
 }
+EXPORT_SYMBOL_GPL(lpc32xx_return_iram_size);
 
 /*
  * Computes PLL rate from PLL register and input clock
-- 
1.8.3.2
