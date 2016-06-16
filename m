From: yendapally.reddy@broadcom.com (Yendapally Reddy Dhananjaya Reddy)
Date: Thu, 16 Jun 2016 09:53:32 -0400
Subject: [PATCH 4/7] ata: ahci_brcmstb: rename to support across Broadcom SoC's
In-Reply-To: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
References: <1466085215-10246-1-git-send-email-yendapally.reddy@broadcom.com>
Message-ID: <1466085215-10246-5-git-send-email-yendapally.reddy@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Rename the existing Broadcom STB ahci driver to common
Broadcom SATA3 driver to share this across Broadcom SoCs.

Signed-off-by: Yendapally Reddy Dhananjaya Reddy <yendapally.reddy@broadcom.com>
---
 drivers/ata/Kconfig                         | 6 +++---
 drivers/ata/Makefile                        | 2 +-
 drivers/ata/{ahci_brcmstb.c => ahci_brcm.c} | 0
 3 files changed, 4 insertions(+), 4 deletions(-)
 rename drivers/ata/{ahci_brcmstb.c => ahci_brcm.c} (100%)

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index e2dc4c0..8fe06e6 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -98,12 +98,12 @@ config SATA_AHCI_PLATFORM
 
 	  If unsure, say N.
 
-config AHCI_BRCMSTB
-	tristate "Broadcom STB AHCI SATA support"
+config AHCI_BRCM
+	tristate "Broadcom AHCI SATA support"
 	depends on ARCH_BRCMSTB || BMIPS_GENERIC
 	help
 	  This option enables support for the AHCI SATA3 controller found on
-	  STB SoC's.
+	  Broadcom SoC's.
 
 	  If unsure, say N.
 
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 0b2afb7..a46e6b7 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_SATA_INIC162X)	+= sata_inic162x.o
 obj-$(CONFIG_SATA_SIL24)	+= sata_sil24.o
 obj-$(CONFIG_SATA_DWC)		+= sata_dwc_460ex.o
 obj-$(CONFIG_SATA_HIGHBANK)	+= sata_highbank.o libahci.o
-obj-$(CONFIG_AHCI_BRCMSTB)	+= ahci_brcmstb.o libahci.o libahci_platform.o
+obj-$(CONFIG_AHCI_BRCM)		+= ahci_brcm.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_CEVA)		+= ahci_ceva.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_DA850)	+= ahci_da850.o libahci.o libahci_platform.o
 obj-$(CONFIG_AHCI_IMX)		+= ahci_imx.o libahci.o libahci_platform.o
diff --git a/drivers/ata/ahci_brcmstb.c b/drivers/ata/ahci_brcm.c
similarity index 100%
rename from drivers/ata/ahci_brcmstb.c
rename to drivers/ata/ahci_brcm.c
-- 
2.1.0
