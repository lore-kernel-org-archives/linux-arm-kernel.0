From: robherring2@gmail.com (Rob Herring)
Date: Fri, 31 Aug 2012 13:29:21 -0500
Subject: [PATCH 3/3] ARM: vexpress: move debug macros to include/debug
In-Reply-To: <1346437761-17039-1-git-send-email-robherring2@gmail.com>
References: <1346437761-17039-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346437761-17039-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move vexpress debug-macro.S over to common debug macro directory.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig.debug                             |    1 +
 .../debug-macro.S => include/debug/vexpress.S}     |    0
 2 files changed, 1 insertion(+)
 rename arch/arm/{mach-vexpress/include/mach/debug-macro.S => include/debug/vexpress.S} (100%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 71214ab..2256944 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -377,6 +377,7 @@ config DEBUG_LL_INCLUDE
 	string
 	default "debug/icedcc.S" if DEBUG_ICEDCC
 	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
+	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
 	default "mach/debug-macros.S"
 
 config EARLY_PRINTK
diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S b/arch/arm/include/debug/vexpress.S
similarity index 100%
rename from arch/arm/mach-vexpress/include/mach/debug-macro.S
rename to arch/arm/include/debug/vexpress.S
-- 
1.7.9.5
