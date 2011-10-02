From: arnd@arndb.de (Arnd Bergmann)
Date: Sun,  2 Oct 2011 22:28:01 +0200
Subject: [PATCH 3/6] ASoC: imx: eukrea_tlv320 needs i2c
In-Reply-To: <1317587284-2776-1-git-send-email-arnd@arndb.de>
References: <1317587284-2776-1-git-send-email-arnd@arndb.de>
Message-ID: <1317587284-2776-4-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add a missing dependency that is required for random configurations.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Cc: "Eric B?nard" <eric@eukrea.com>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
---
 sound/soc/imx/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/sound/soc/imx/Kconfig b/sound/soc/imx/Kconfig
index bb699bb..dcd954b 100644
--- a/sound/soc/imx/Kconfig
+++ b/sound/soc/imx/Kconfig
@@ -50,6 +50,7 @@ config SND_SOC_EUKREA_TLV320
 		|| MACH_EUKREA_MBIMXSD25_BASEBOARD \
 		|| MACH_EUKREA_MBIMXSD35_BASEBOARD \
 		|| MACH_EUKREA_MBIMXSD51_BASEBOARD
+	depends on I2C
 	select SND_SOC_TLV320AIC23
 	select SND_MXC_SOC_FIQ
 	help
-- 
1.7.5.4
