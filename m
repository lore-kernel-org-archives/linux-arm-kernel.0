From: pebolle@tiscali.nl (Paul Bolle)
Date: Sun, 14 Jul 2013 14:26:52 +0200
Subject: [PATCH] ARM: EXYNOS: remove references to non-DT SoCs
Message-ID: <1373804812.1370.23.camel@x61.thuisdomein>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit 383ffda2fa ("ARM: EXYNOS: no more support non-DT for EXYNOS
SoCs") removed the Kconfig symbols MACH_SMDKV310 and MACH_SMDKC210.
Now remove the references to both of these symbols from the Kconfig
entry for SND_SOC_SAMSUNG_SMDK_WM9713. They're not needed anymore.

Signed-off-by: Paul Bolle <pebolle@tiscali.nl>
---
Untested.

 sound/soc/samsung/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 9855dfc..3d76659 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -136,7 +136,7 @@ config SND_SOC_SAMSUNG_RX1950_UDA1380
 
 config SND_SOC_SAMSUNG_SMDK_WM9713
 	tristate "SoC AC97 Audio support for SMDK with WM9713"
-	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110 || MACH_SMDKV310 || MACH_SMDKC210)
+	depends on SND_SOC_SAMSUNG && (MACH_SMDK6410 || MACH_SMDKC100 || MACH_SMDKV210 || MACH_SMDKC110)
 	select SND_SOC_WM9713
 	select SND_SAMSUNG_AC97
 	help
-- 
1.8.1.4
