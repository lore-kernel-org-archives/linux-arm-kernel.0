From: lee.jones@linaro.org (Lee Jones)
Date: Wed, 12 Mar 2014 12:39:41 +0000
Subject: [PATCH 4/5] ahci: st: Only build for ST-Micro h/w
In-Reply-To: <1394627982-23726-1-git-send-email-lee.jones@linaro.org>
References: <1394627982-23726-1-git-send-email-lee.jones@linaro.org>
Message-ID: <1394627982-23726-5-git-send-email-lee.jones@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This device is designed specifically to run on ST-Microelectronics'
hardware. To ensure no attempts are made to run on anything incompatible
we add a dependency on ST architecture

Suggested-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
---
 drivers/ata/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index f1adb4b..9b4feb7 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -100,6 +100,7 @@ config SATA_AHCI_PLATFORM
 config AHCI_ST
 	tristate "ST AHCI SATA support"
 	depends on SATA_AHCI_PLATFORM
+	depends on ARCH_STI
 	help
 	  This option enables support for ST AHCI SATA controller.
 
-- 
1.8.3.2
