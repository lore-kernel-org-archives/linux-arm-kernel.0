From: robherring2@gmail.com (Rob Herring)
Date: Fri, 31 Aug 2012 13:29:20 -0500
Subject: [PATCH 2/3] ARM: highbank: move debug macros to include/debug
In-Reply-To: <1346437761-17039-1-git-send-email-robherring2@gmail.com>
References: <1346437761-17039-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346437761-17039-2-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move highbank debug-macro.S over to common debug macro directory.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig.debug                             |    1 +
 .../debug-macro.S => include/debug/highbank.S}     |    0
 2 files changed, 1 insertion(+)
 rename arch/arm/{mach-highbank/include/mach/debug-macro.S => include/debug/highbank.S} (100%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 71bbda2..71214ab 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -376,6 +376,7 @@ endchoice
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/icedcc.S" if DEBUG_ICEDCC
+	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
 	default "mach/debug-macros.S"
 
 config EARLY_PRINTK
diff --git a/arch/arm/mach-highbank/include/mach/debug-macro.S b/arch/arm/include/debug/highbank.S
similarity index 100%
rename from arch/arm/mach-highbank/include/mach/debug-macro.S
rename to arch/arm/include/debug/highbank.S
-- 
1.7.9.5
