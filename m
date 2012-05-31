From: ludovic.desroches@atmel.com (ludovic.desroches at atmel.com)
Date: Thu, 31 May 2012 17:26:05 +0200
Subject: [PATCH] ARM: at91: fix at91_aic_write macro
Message-ID: <1338477965-19581-1-git-send-email-ludovic.desroches@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ludovic Desroches <ludovic.desroches@atmel.com>

Fix at91_aic_write macro to avoid potential issues.

Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
---
 arch/arm/mach-at91/include/mach/at91_aic.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-at91/include/mach/at91_aic.h b/arch/arm/mach-at91/include/mach/at91_aic.h
index 3045781..c1413ed 100644
--- a/arch/arm/mach-at91/include/mach/at91_aic.h
+++ b/arch/arm/mach-at91/include/mach/at91_aic.h
@@ -23,7 +23,7 @@ extern void __iomem *at91_aic_base;
 	__raw_readl(at91_aic_base + field)
 
 #define at91_aic_write(field, value) \
-	__raw_writel(value, at91_aic_base + field);
+	__raw_writel(value, at91_aic_base + field)
 #else
 .extern at91_aic_base
 #endif
-- 
1.7.5.4
