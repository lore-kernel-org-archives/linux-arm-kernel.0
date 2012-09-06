From: robherring2@gmail.com (Rob Herring)
Date: Thu,  6 Sep 2012 15:12:49 -0500
Subject: [PATCH 06/12] ARM: picoxcell: move debug macros to include/debug
In-Reply-To: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
References: <1346962375-26163-1-git-send-email-robherring2@gmail.com>
Message-ID: <1346962375-26163-7-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

Move picoxcell debug-macro.S over to common debug macro directory.

Signed-off-by: Rob Herring <rob.herring@calxeda.com>
Cc: Jamie Iles <jamie@jamieiles.com>
---
 arch/arm/Kconfig.debug                             |    8 ++++++++
 .../debug-macro.S => include/debug/picoxcell.S}    |    0
 2 files changed, 8 insertions(+)
 rename arch/arm/{mach-picoxcell/include/mach/debug-macro.S => include/debug/picoxcell.S} (100%)

diff --git a/arch/arm/Kconfig.debug b/arch/arm/Kconfig.debug
index aa56934..b74ed97 100644
--- a/arch/arm/Kconfig.debug
+++ b/arch/arm/Kconfig.debug
@@ -268,6 +268,13 @@ choice
 		  Say Y here if you want kernel low-level debugging support
 		  on MVEBU based platforms.
 
+	config DEBUG_PICOXCELL_UART
+		depends on ARCH_PICOXCELL
+		bool "Use PicoXcell UART for low-level debug"
+		help
+		  Say Y here if you want kernel low-level debugging support
+		  on PicoXcell based platforms.
+
 	config DEBUG_REALVIEW_STD_PORT
 		bool "RealView Default UART"
 		depends on ARCH_REALVIEW
@@ -392,6 +399,7 @@ config DEBUG_LL_INCLUDE
 	default "debug/icedcc.S" if DEBUG_ICEDCC
 	default "debug/highbank.S" if DEBUG_HIGHBANK_UART
 	default "debug/mvebu.S" if DEBUG_MVEBU_UART
+	default "debug/picoxcell.S" if DEBUG_PICOXCELL_UART
 	default "debug/socfpga.S" if DEBUG_SOCFPGA_UART
 	default "debug/vexpress.S" if DEBUG_VEXPRESS_UART0_DETECT || \
 		DEBUG_VEXPRESS_UART0_CA9 || DEBUG_VEXPRESS_UART0_RS1
diff --git a/arch/arm/mach-picoxcell/include/mach/debug-macro.S b/arch/arm/include/debug/picoxcell.S
similarity index 100%
rename from arch/arm/mach-picoxcell/include/mach/debug-macro.S
rename to arch/arm/include/debug/picoxcell.S
-- 
1.7.9.5
