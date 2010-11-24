From: mad_soft@inbox.ru (Dmitry Artamonow)
Date: Thu, 25 Nov 2010 00:46:15 +0300
Subject: [PATCH] ASoC: fix SND_PXA2XX_LIB Kconfig warning
Message-ID: <1290635175-30501-1-git-send-email-mad_soft@inbox.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Fix following warning observed when SND_PXA2XX_SOC is set and SND_ARM isn't:

warning: (SND_PXA2XX_AC97 && SOUND && !M68K && SND && SND_ARM && ARCH_PXA ||
SND_PXA2XX_SOC && SOUND && !M68K && SND && SND_SOC && ARCH_PXA) selects
SND_PXA2XX_LIB which has unmet direct dependencies (SOUND && !M68K && SND &&
SND_ARM)

Signed-off-by: Dmitry Artamonow <mad_soft@inbox.ru>
---

This is fix for 2.6.37-rc3

 sound/soc/pxa/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/pxa/Kconfig b/sound/soc/pxa/Kconfig
index 37f191b..580f485 100644
--- a/sound/soc/pxa/Kconfig
+++ b/sound/soc/pxa/Kconfig
@@ -1,6 +1,7 @@
 config SND_PXA2XX_SOC
 	tristate "SoC Audio for the Intel PXA2xx chip"
 	depends on ARCH_PXA
+	select SND_ARM
 	select SND_PXA2XX_LIB
 	help
 	  Say Y or M if you want to add support for codecs attached to
-- 
1.7.0.4
