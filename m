From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 16 Oct 2015 22:05:34 +0200
Subject: [PATCH] staging: wilc1000: restore wilc_spi_dev variable
Message-ID: <4978401.AVrDN2jmbq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

A recent change to wilc1000 accidentally deleted an important
variable, so we now get a build error when the SPI mode is
selected:

ERROR: "wilc_spi_dev" [drivers/staging/wilc1000/wilc1000.ko] undefined!

This partially reverts the broken commit to put the variable back.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Fixes: 56293ff232b9 ("staging: wilc1000: linux_wlan_spi: include header")
---
Found on ARM randconfig builds.

diff --git a/drivers/staging/wilc1000/linux_wlan_spi.c b/drivers/staging/wilc1000/linux_wlan_spi.c
index 760b72a9a6ff..039d06192d6b 100644
--- a/drivers/staging/wilc1000/linux_wlan_spi.c
+++ b/drivers/staging/wilc1000/linux_wlan_spi.c
@@ -41,6 +41,7 @@
 
 static u32 SPEED = MIN_SPEED;
 
+struct spi_device *wilc_spi_dev;
 void linux_spi_deinit(void *vp);
 
 static int __init wilc_bus_probe(struct spi_device *spi)
