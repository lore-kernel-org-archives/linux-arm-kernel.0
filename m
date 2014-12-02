From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Tue, 2 Dec 2014 18:27:21 +0100
Subject: [PATCH 1/8] ARM: at91/Kconfig: select board files automatically
In-Reply-To: <201411282152.08438.arnd@arndb.de>
References: <201411282152.08438.arnd@arndb.de>
Message-ID: <e093d7cf37ec9ff24b0631b0a2e405a7cf7574db.1417541118.git.nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>

An explicit selection option is not needed for board files so now we select the
board from SoC option.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
[nicolas.ferre at atmel.com: remove option's comments; split patch]
Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
---
 arch/arm/mach-at91/Kconfig | 14 ++------------
 1 file changed, 2 insertions(+), 12 deletions(-)

diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 231893d71658..2395c68b3e32 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -174,21 +174,11 @@ config SOC_AT91SAM9N12
 # ----------------------------------------------------------
 endif # SOC_SAM_V4_V5
 
-comment "Generic Board Type"
-
 config MACH_AT91RM9200_DT
-	bool "Atmel AT91RM9200 Evaluation Kits with device-tree support"
-	depends on SOC_AT91RM9200
-	help
-	  Select this if you want to experiment device-tree with
-	  an Atmel RM9200 Evaluation Kit.
+	def_bool SOC_AT91RM9200
 
 config MACH_AT91SAM9_DT
-	bool "Atmel AT91SAM Evaluation Kits with device-tree support"
-	depends on SOC_AT91SAM9
-	help
-	  Select this if you want to experiment device-tree with
-	  an Atmel Evaluation Kit.
+	def_bool SOC_AT91SAM9
 
 # ----------------------------------------------------------
 
-- 
2.1.3
