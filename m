From: arnd@arndb.de (Arnd Bergmann)
Date: Thu,  5 Jun 2014 23:24:13 +0200
Subject: [PATCH 2/3] mfd: davinci voicecodec need regmap_mmio
In-Reply-To: <1402003454-1989084-1-git-send-email-arnd@arndb.de>
References: <1402003454-1989084-1-git-send-email-arnd@arndb.de>
Message-ID: <1402003454-1989084-3-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Without REGMAP_MMIO, building that driver results in a link error:

drivers/built-in.o: In function `davinci_vc_probe':
:(.init.text+0x3c1c): undefined reference to `devm_regmap_init_mmio_clk'

This adds a Kconfig 'select' statement as the usual way to ensure
that REGMAP_MMIO is enabled.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mfd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
index 4370692..2dd838f 100644
--- a/drivers/mfd/Kconfig
+++ b/drivers/mfd/Kconfig
@@ -760,6 +760,7 @@ config MFD_SYSCON
 config MFD_DAVINCI_VOICECODEC
 	tristate
 	select MFD_CORE
+	select REGMAP_MMIO
 
 config MFD_TI_AM335X_TSCADC
 	tristate "TI ADC / Touch Screen chip support"
-- 
1.8.3.2
