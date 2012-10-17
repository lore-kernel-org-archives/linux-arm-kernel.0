From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 17 Oct 2012 15:41:31 +0200
Subject: [PATCH 1/1] arm: at91: drop duplicated config SOC_AT91SAM9 entry
Message-ID: <1350481291-32579-1-git-send-email-plagnioj@jcrosoft.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Signed-off-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>
Cc: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig |   10 ++--------
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
1.7.10.4
