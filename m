From: b.zolnierkie@samsung.com (Bartlomiej Zolnierkiewicz)
Date: Wed, 26 Mar 2014 15:33:37 +0100
Subject: [PATCH] ata: fix ARASAN CompactFlash PATA driver dependencies
Message-ID: <1565826.7Ejj6LS6x7@amdc1032>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Make pata_arasan_cf host driver depend on ARCH_SPEAR13XX config
option as ARASAN CompactFlash PATA support is specific to ST
SPEAr13xx SoCs and the driver to work requires suitable device
tree node (or platform device) to be defined.  Additionally
allow the driver build if COMPILE_TEST config option is set.

Cc: Viresh Kumar <viresh.linux@gmail.com>
Cc: Shiraz Hashim <shiraz.hashim@st.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/Kconfig |    1 +
 1 file changed, 1 insertion(+)

Index: b/drivers/ata/Kconfig
===================================================================
--- a/drivers/ata/Kconfig	2014-03-26 15:09:47.395143062 +0100
+++ b/drivers/ata/Kconfig	2014-03-26 15:21:29.535131088 +0100
@@ -378,6 +378,7 @@ config PATA_AMD
 
 config PATA_ARASAN_CF
 	tristate "ARASAN CompactFlash PATA Controller Support"
+	depends on ARCH_SPEAR13XX || COMPILE_TEST
 	depends on DMADEVICES
 	select DMA_ENGINE
 	help
