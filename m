From: marek.vasut@gmail.com (Marek Vasut)
Date: Sun, 8 Nov 2009 03:05:11 +0100
Subject: [PATCH 1/2] Colibri/PXA320: Fix AC97 ifdefs and include
Message-ID: <200911080305.11772.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 39b8a11d86905c0ed50932aa4f57dce8c46e9dd9 Mon Sep 17 00:00:00 2001
From: Marek Vasut <marek.vasut@gmail.com>
Date: Sun, 8 Nov 2009 02:24:05 +0100
Subject: [PATCH 1/2] Colibri/PXA320: Fix AC97 ifdefs and include

The AC97 part wasn't initialized on Colibri/PXA320 because the macros were
wrong. Also, the code didn't compile because of a header file not being
included.

Signed-off-by: Marek Vasut <marek.vasut@gmail.com>
---
 arch/arm/mach-pxa/colibri-pxa320.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/arch/arm/mach-pxa/colibri-pxa320.c b/arch/arm/mach-pxa/colibri-
pxa320.c
index 4945728..ec0e14b 100644
--- a/arch/arm/mach-pxa/colibri-pxa320.c
+++ b/arch/arm/mach-pxa/colibri-pxa320.c
@@ -27,6 +27,7 @@
 #include <mach/colibri.h>
 #include <mach/pxafb.h>
 #include <mach/ohci.h>
+#include <mach/audio.h>
 
 #include "generic.h"
 #include "devices.h"
@@ -145,7 +146,8 @@ static void __init colibri_pxa320_init_lcd(void)
 static inline void colibri_pxa320_init_lcd(void) {}
 #endif
 
-#if defined(SND_AC97_CODEC) || defined(SND_AC97_CODEC_MODULE)
+#if	defined(CONFIG_SND_AC97_CODEC) || \
+	defined(CONFIG_SND_AC97_CODEC_MODULE)
 static mfp_cfg_t colibri_pxa320_ac97_pin_config[] __initdata = {
 	GPIO34_AC97_SYSCLK,
 	GPIO35_AC97_SDATA_IN_0,
-- 
1.6.5
