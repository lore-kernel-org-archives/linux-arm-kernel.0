From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Wed, 24 Oct 2012 17:33:57 +0200
Subject: [PATCH 8/8] ARM: at91: drop duplicated config SOC_AT91SAM9 entry
In-Reply-To: <cover.1351092432.git.nicolas.ferre@atmel.com>
References: <cover.1351092432.git.nicolas.ferre@atmel.com>
Message-ID: <08bd4ab3897a5b06b4eb5cf3c00532ba38305be4.1351092432.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Acked-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index b142071..0436242 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -21,19 +21,13 @@ config SOC_AT91SAM9
 	bool
 	select CPU_ARM926T
 	select GENERIC_CLOCKEVENTS
+	select MULTI_IRQ_HANDLER
+	select SPARSE_IRQ
 
 menu "Atmel AT91 System-on-Chip"
 
 comment "Atmel AT91 Processor"
 
-config SOC_AT91SAM9
-	bool
-	select AT91_SAM9_SMC
-	select AT91_SAM9_TIME
-	select CPU_ARM926T
-	select MULTI_IRQ_HANDLER
-	select SPARSE_IRQ
-
 config SOC_AT91RM9200
 	bool "AT91RM9200"
 	select CPU_ARM920T
-- 
1.7.11.3
