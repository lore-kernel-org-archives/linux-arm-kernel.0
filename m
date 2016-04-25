From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 26 Apr 2016 00:55:30 +0200
Subject: [PATCH] soc: brcmstb: select SOC_BUS
Message-ID: <1461625017-1939162-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The newly added code for the SoC bus fails to link if the
bus is not built:

drivers/soc/built-in.o: In function `brcmstb_soc_device_init':
:(.init.text+0x110): undefined reference to `soc_device_register'

This adds a 'select' statement to avoid the error.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/soc/brcmstb/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/brcmstb/Kconfig b/drivers/soc/brcmstb/Kconfig
index 39cab3b..7fec3b4 100644
--- a/drivers/soc/brcmstb/Kconfig
+++ b/drivers/soc/brcmstb/Kconfig
@@ -1,6 +1,7 @@
 menuconfig SOC_BRCMSTB
 	bool "Broadcom STB SoC drivers"
 	depends on ARM
+	select SOC_BUS
 	help
 	  Enables drivers for the Broadcom Set-Top Box (STB) series of chips.
 	  This option alone enables only some support code, while the drivers
-- 
2.7.0
