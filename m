From: robherring2@gmail.com (Rob Herring)
Date: Thu,  6 Sep 2012 15:12:45 -0500
Subject: [PATCH 02/12] ARM: highbank: move debug macros to include/debug
In-Reply-To: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346962375-26163-3-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move highbank debug-macro.S over to common debug macro directory.

Also, remove v7 specific movw/movt instructions so this can compile under
v6 mode.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
---
 arch/arm/Kconfig.debug                             |    1 +
 .../debug-macro.S => include/debug/highbank.S}     |    6 ++----
 2 files changed, 3 insertions(+), 4 deletions(-)
 rename arch/arm/{mach-highbank/include/mach/debug-macro.S => include/debug/highbank.S} (83%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index 4f9760b..d9d8eff 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -376,6 +376,7 @@ endchoice
 config DEBUG_LL_INCLUDE
 	string
 	default "debug/icedcc.S" if DEBUG_ICEDCC
+	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
 	default "mach/debug-macro.S"
 
 config EARLY_PRINTK
diff --git a/arch/arm/mach-highbank/include/mach/debug-macro.S b/arch/arm/include/debug/highbank.S
similarity index 83%
rename from arch/arm/mach-highbank/include/mach/debug-macro.S
rename to arch/arm/include/debug/highbank.S
index cb57fe5..8cad432 100644
--- a/arch/arm/mach-highbank/include/mach/debug-macro.S
+++ b/arch/arm/include/debug/highbank.S
@@ -10,10 +10,8 @@
  */
 
 		.macro	addruart,rp,rv,tmp
-		movw	\rv, #0x6000
-		movt	\rv, #0xfee3
-		movw	\rp, #0x6000
-		movt	\rp, #0xfff3
+		ldr	\rv, =0xfee36000
+		ldr	\rp, =0xfff36000
 		.endm
 
 #include <asm/hardware/debug-pl01x.S>
-- 
1.7.9.5
