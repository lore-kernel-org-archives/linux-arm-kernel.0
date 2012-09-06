From: robherring2@gmail.com (Rob Herring)
Date: Thu,  6 Sep 2012 15:12:46 -0500
Subject: [PATCH 03/12] ARM: vexpress: move debug macros to include/debug
In-Reply-To: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346962375-26163-4-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move vexpress debug-macro.S over to common debug macro directory.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Pawel Moll <pawel.moll@arm.com>
---
 arch/arm/Kconfig.debug                             |    2 ++
 .../debug-macro.S => include/debug/vexpress.S}     |    0
 2 files changed, 2 insertions(+)
 rename arch/arm/{mach-vexpress/include/mach/debug-macro.S => include/debug/vexpress.S} (100%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index d9d8eff..525d9bd 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -377,6 +377,8 @@ config DEBUG_LL_INCLUDE
 	string
 	default "debug/icedcc.S" if DEBUG_ICEDCC
 	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
+	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
+		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
 	default "mach/debug-macro.S"
 
 config EARLY_PRINTK
diff --git a/arch/arm/mach-vexpress/include/mach/debug-macro.S b/arch/arm/include/debug/vexpress.S
similarity index 100%
rename from arch/arm/mach-vexpress/include/mach/debug-macro.S
rename to arch/arm/include/debug/vexpress.S
-- 
1.7.9.5
