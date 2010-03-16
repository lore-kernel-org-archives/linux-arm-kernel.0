From: eric.y.miao@gmail.com (Eric Miao)
Date: Tue, 16 Mar 2010 19:52:53 +0800
Subject: [PATCH 8/8] [ARM] pxa: remove incorrect select PXA_SSP in Kconfig
In-Reply-To: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
References: <1268740373-27407-1-git-send-email-eric.y.miao@gmail.com>
Message-ID: <1268740373-27407-9-git-send-email-eric.y.miao@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PXA_SSP is actually used by drivers like drivers/spi/pxa2xx_spi.c and
sound/soc/pxa/pxa-ssp.c, not by boards. Remove those incorrect 'select'
from Kconfig and make SOC_PXA_SSP to select.

Signed-off-by: Eric Miao <eric.y.miao@gmail.com>
---
 arch/arm/mach-pxa/Kconfig |   13 -------------
 sound/soc/pxa/Kconfig     |    1 +
 2 files changed, 1 insertions(+), 13 deletions(-)

diff --git a/arch/arm/mach-pxa/Kconfig b/arch/arm/mach-pxa/Kconfig
index 6dd450a..352dc4f 100644
--- a/arch/arm/mach-pxa/Kconfig
+++ b/arch/arm/mach-pxa/Kconfig
@@ -19,7 +19,6 @@ config MACH_MAINSTONE
 config MACH_ZYLONITE
 	bool
 	select PXA3xx
-	select PXA_SSP
 	select HAVE_PWM
 	select PXA_HAVE_BOARD_IRQS
 
@@ -39,7 +38,6 @@ config MACH_LITTLETON
 	select PXA3xx
 	select CPU_PXA300
 	select CPU_PXA310
-	select PXA_SSP
 
 config MACH_TAVOREVB
 	bool "PXA930 Evaluation Board (aka TavorEVB)"
@@ -98,7 +96,6 @@ config MACH_ARMCORE
 	select PXA27x
 	select IWMMXT
 	select PXA25x
-	select PXA_SSP
 
 config MACH_EM_X270
 	bool "CompuLab EM-x270 platform"
@@ -161,7 +158,6 @@ config MACH_XCEP
 	select MTD_CFI
 	select MTD_CHAR
 	select SMC91X
-	select PXA_SSP
 	help
 	  PXA255 based Single Board Computer with SMC 91C111 ethernet chip and 64 MB of flash.
 	  Tuned for usage in Libera instruments for particle accelerators.
@@ -180,7 +176,6 @@ config MACH_TRIZEPS4WL
 	depends on TRIZEPS_PXA
 	select TRIZEPS_PCMCIA
 	select PXA27x
-	select PXA_SSP
 
 choice
 	prompt "Select base board for Trizeps module"
@@ -217,7 +212,6 @@ config MACH_PCM027
 	bool "Phytec phyCORE-PXA270 CPU module (PCM-027)"
 	select PXA27x
 	select IWMMXT
-	select PXA_SSP
 	select PXA_HAVE_BOARD_IRQS
 
 config MACH_PCM990_BASEBOARD
@@ -261,7 +255,6 @@ config MACH_H4700
 	bool "HP iPAQ hx4700"
 	select PXA27x
 	select IWMMXT
-	select PXA_SSP
 	select HAVE_PWM
 	select PXA_HAVE_BOARD_IRQS
 
@@ -277,7 +270,6 @@ config MACH_MAGICIAN
 	bool "Enable HTC Magician Support"
 	select PXA27x
 	select IWMMXT
-	select PXA_SSP
 	select HAVE_PWM
 	select PXA_HAVE_BOARD_IRQS
 
@@ -431,13 +423,11 @@ config MACH_RAUMFELD_CONNECTOR
 	bool "Raumfeld Connector"
 	select PXA3xx
 	select CPU_PXA300
-	select PXA_SSP
 
 config MACH_RAUMFELD_SPEAKER
 	bool "Raumfeld Speaker"
 	select PXA3xx
 	select CPU_PXA300
-	select PXA_SSP
 
 config PXA_SHARPSL
 	bool "SHARP Zaurus SL-5600, SL-C7xx and SL-Cxx00 Models"
@@ -466,7 +456,6 @@ config MACH_POODLE
 	depends on PXA_SHARPSL
 	select PXA25x
 	select SHARP_LOCOMO
-	select PXA_SSP
 	select PXA_HAVE_BOARD_IRQS
 
 config MACH_CORGI
@@ -636,14 +625,12 @@ config CPU_PXA950
 
 config PXA_SHARP_C7xx
 	bool
-	select PXA_SSP
 	select SHARPSL_PM
 	help
 	  Enable support for all Sharp C7xx models
 
 config PXA_SHARP_Cxx00
 	bool
-	select PXA_SSP
 	select SHARPSL_PM
 	help
 	  Enable common support for Sharp Cxx00 models
diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 376e14a..78e6121 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -23,6 +23,7 @@ config SND_PXA2XX_SOC_I2S
 
 config SND_PXA_SOC_SSP
 	tristate
+	select PXA_SSP
 
 config SND_PXA2XX_SOC_CORGI
 	tristate "SoC Audio support for Sharp Zaurus SL-C7x0"
-- 
1.6.3.3
