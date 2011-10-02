From: arnd@arndb.de (Arnd Bergmann)
Date: Sun,  2 Oct 2011 22:28:00 +0200
Subject: [PATCH 2/6] ASoC: codecs: AK4641 depends on GPIOLIB
In-Reply-To: <1317587284-2776-1-git-send-email-arnd@arndb.de>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
Message-ID: <1317587284-2776-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This driver only builds correctly on platforms that use
GPIOLIB. Disable it otherwise.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: Dmitry Artamonow <mad_soft@inbox.ru>
---
 sound/soc/codecs/Kconfig |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/sound/soc/codecs/Kconfig b/sound/soc/codecs/Kconfig
index 665d924..4d41447 100644
--- a/sound/soc/codecs/Kconfig
+++ b/sound/soc/codecs/Kconfig
@@ -21,7 +21,7 @@ config SND_SOC_ALL_CODECS
 	select SND_SOC_ADS117X
 	select SND_SOC_AK4104 if SPI_MASTER
 	select SND_SOC_AK4535 if I2C
-	select SND_SOC_AK4641 if I2C
+	select SND_SOC_AK4641 if I2C && GPIOLIB
 	select SND_SOC_AK4642 if I2C
 	select SND_SOC_AK4671 if I2C
 	select SND_SOC_ALC5623 if I2C
-- 
1.7.5.4
