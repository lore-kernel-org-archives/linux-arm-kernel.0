From: arnd@arndb.de (Arnd Bergmann)
Date: Sun,  2 Oct 2011 22:28:03 +0200
Subject: [PATCH 5/6] ASoC: samsung: fix Kconfig dependencies
In-Reply-To: <1317587284-2776-1-git-send-email-arnd@arndb.de>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
Message-ID: <1317587284-2776-6-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

SND_SOC_WM8994 can only be selected if the respective MFD driver is
present.

SND_SAMSUNG_AC97 must not be builtin if SND_SOC_ALL_CODECS is
set to building all drivers as modules.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Sangbeom Kim <sbkim73@samsung.com>
---
 sound/soc/samsung/Kconfig |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/sound/soc/samsung/Kconfig b/sound/soc/samsung/Kconfig
index 65f980e..cb63cd0 100644
--- a/sound/soc/samsung/Kconfig
+++ b/sound/soc/samsung/Kconfig
@@ -25,6 +25,7 @@ config SND_SAMSUNG_PCM
 
 config SND_SAMSUNG_AC97
 	tristate
+	depends on SND_SOC_ALL_CODECS=n || SND_SOC_ALL_CODECS
 	select SND_SOC_AC97_BUS
 
 config SND_SAMSUNG_SPDIF
@@ -64,6 +65,7 @@ config SND_SOC_SAMSUNG_SMDK_WM8580
 config SND_SOC_SAMSUNG_SMDK_WM8994
 	tristate "SoC I2S Audio support for WM8994 on SMDK"
 	depends on SND_SOC_SAMSUNG && (MACH_SMDKV310 || MACH_SMDKC210)
+	depends on MFD_WM8994
 	select SND_SOC_WM8994
 	select SND_SAMSUNG_I2S
 	help
@@ -151,6 +153,7 @@ config SND_SOC_GONI_AQUILA_WM8994
 	tristate "SoC I2S Audio support for AQUILA/GONI - WM8994"
 	depends on SND_SOC_SAMSUNG && (MACH_GONI || MACH_AQUILA)
 	select SND_SAMSUNG_I2S
+	depends on MFD_WM8994
 	select SND_SOC_WM8994
 	help
 	  Say Y if you want to add support for SoC audio on goni or aquila
@@ -174,6 +177,7 @@ config SND_SOC_SMDK_WM8580_PCM
 config SND_SOC_SMDK_WM8994_PCM
 	tristate "SoC PCM Audio support for WM8994 on SMDK"
 	depends on SND_SOC_SAMSUNG && (MACH_SMDKC210 || MACH_SMDKV310)
+	depends on MFD_WM8994
 	select SND_SOC_WM8994
 	select SND_SAMSUNG_PCM
 	help
-- 
1.7.5.4
