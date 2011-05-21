From: pavel@ucw.cz (Pavel Machek)
Date: Sat, 21 May 2011 11:43:26 +0200
Subject: Disable CF during suspend
Message-ID: <20110521094326.GB26323@elf.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Disable SPITZ_SCP_CF_POWER during suspend. Otherwise it eats battery,
fast. Thanks to Stanislav Brabec.
    
Signed-off-by: Pavel Machek <pavel@ucw.cz>
    
diff --git a/arch/arm/mach-pxa/include/mach/spitz.h b/arch/arm/mach-pxa/include/mach/spitz.h
index 685749a..06b7cbc 100644
--- a/arch/arm/mach-pxa/include/mach/spitz.h
+++ b/arch/arm/mach-pxa/include/mach/spitz.h
@@ -96,7 +96,7 @@
 #define SPITZ_SCP_CHRG_ON       SCOOP_GPCR_PA13  /* Keep */
 #define SPITZ_SCP_MUTE_L        SCOOP_GPCR_PA14  /* Low */
 #define SPITZ_SCP_MUTE_R        SCOOP_GPCR_PA15  /* Low */
-#define SPITZ_SCP_CF_POWER      SCOOP_GPCR_PA16  /* Keep */
+#define SPITZ_SCP_CF_POWER      SCOOP_GPCR_PA16  /* Low, CF card eats power */
 #define SPITZ_SCP_LED_ORANGE    SCOOP_GPCR_PA17  /* Keep */
 #define SPITZ_SCP_JK_A          SCOOP_GPCR_PA18  /* Low */
 #define SPITZ_SCP_ADC_TEMP_ON   SCOOP_GPCR_PA19  /* Low */
@@ -105,7 +105,7 @@
                                SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R | \
                                SPITZ_SCP_CF_POWER | SPITZ_SCP_JK_A | SPITZ_SCP_ADC_TEMP_ON)
 #define SPITZ_SCP_IO_OUT      (SPITZ_SCP_CHRG_ON | SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R)
-#define SPITZ_SCP_SUS_CLR     (SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R | SPITZ_SCP_JK_A | SPITZ_SCP_ADC_TEMP_ON)
+#define SPITZ_SCP_SUS_CLR     (SPITZ_SCP_MUTE_L | SPITZ_SCP_MUTE_R | SPITZ_SCP_JK_A | SPITZ_SCP_ADC_TEMP_ON | SPITZ_SCP_CF_POWER)
 #define SPITZ_SCP_SUS_SET     0
 
 #define SPITZ_SCP_GPIO_BASE	(NR_BUILTIN_GPIO)

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
