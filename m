From: pebolle@tiscali.nl (Paul Bolle)
Date: Tue, 12 Mar 2013 23:09:35 +0100
Subject: [PATCH] ASoC: samsung: remove last traces of neo1973-gta01
Message-ID: <1363126175.3137.160.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The (rudimentary) support for the Openmoko Neo1973 GTA01 got removed in
commit 1ae5cbc52e7c6619a3f44b87809fd25370df31bb ("ASoC: neo1973_wm8753:
remove references to the neo1973-gta01 machine"). Remove its last traces
in the Kconfig file too.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 sound/soc/samsung/Kconfig | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 90e7e66..475fb0d 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -35,11 +35,10 @@ config SND_SAMSUNG_I2S
 	tristate
 
 config SND_SOC_SAMSUNG_NEO1973_WM8753
-	tristate "Audio support for Openmoko Neo1973 Smartphones (GTA01/GTA02)"
-	depends on SND_SOC_SAMSUNG && (MACH_NEO1973_GTA01 || MACH_NEO1973_GTA02)
+	tristate "Audio support for Openmoko Neo1973 Smartphones (GTA02)"
+	depends on SND_SOC_SAMSUNG && MACH_NEO1973_GTA02
 	select SND_S3C24XX_I2S
 	select SND_SOC_WM8753
-	select SND_SOC_LM4857 if MACH_NEO1973_GTA01
 	select SND_SOC_DFBMCS320
 	help
 	  Say Y here to enable audio support for the Openmoko Neo1973
-- 
1.7.11.7
