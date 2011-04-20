From: b32955@freescale.com (Huang Shijie)
Date: Wed, 20 Apr 2011 10:45:49 +0800
Subject: [PATCH v6 3/3] MTD : add GPMI driver in the config and Makefile
In-Reply-To: <1303267549-18377-1-git-send-email-b32955@freescale.com>
References: <1303267549-18377-1-git-send-email-b32955@freescale.com>
Message-ID: <1303267549-18377-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the GPMI driver in the relevant Kconfig and Makefile in the MTD.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/Kconfig           |   11 +++++++++++
 drivers/mtd/nand/Makefile          |    1 +
 drivers/mtd/nand/gpmi-nfc/Makefile |    3 +++
 3 files changed, 15 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/gpmi-nfc/Makefile

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 450afc5..25a1493 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -426,6 +426,17 @@ config MTD_NAND_NANDSIM
 	  The simulator may simulate various NAND flash chips for the
 	  MTD nand layer.
 
+config MTD_NAND_GPMI_NFC
+        bool "GPMI NAND Flash Controller driver"
+        depends on MTD_NAND && (SOC_IMX23 || SOC_IMX28)
+	select MTD_PARTITIONS
+	select MTD_CMDLINE_PARTS
+        help
+	 Enables NAND Flash support for IMX23 or IMX28.
+	 The GPMI controller is very powerful, with the help of BCH
+	 module, it can do the hardware ECC. The GPMI supports several
+	 NAND flashs at the same time.
+
 config MTD_NAND_PLATFORM
 	tristate "Support for generic platform NAND driver"
 	help
diff --git a/drivers/mtd/nand/Makefile b/drivers/mtd/nand/Makefile
index 8ad6fae..80d1f08 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -48,5 +48,6 @@ obj-$(CONFIG_MTD_NAND_BCM_UMI)		+= bcm_umi_nand.o nand_bcm_umi.o
 obj-$(CONFIG_MTD_NAND_MPC5121_NFC)	+= mpc5121_nfc.o
 obj-$(CONFIG_MTD_NAND_RICOH)		+= r852.o
 obj-$(CONFIG_MTD_NAND_JZ4740)		+= jz4740_nand.o
+obj-$(CONFIG_MTD_NAND_GPMI_NFC)		+= gpmi-nfc/
 
 nand-objs := nand_base.o nand_bbt.o
diff --git a/drivers/mtd/nand/gpmi-nfc/Makefile b/drivers/mtd/nand/gpmi-nfc/Makefile
new file mode 100644
index 0000000..918fb52
--- /dev/null
+++ b/drivers/mtd/nand/gpmi-nfc/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_MTD_NAND_GPMI_NFC) += gpmi_nfc.o
+gpmi_nfc-objs += gpmi-nfc.o
+gpmi_nfc-objs += hal-mxs.o
-- 
1.7.0.4
