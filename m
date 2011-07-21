From: b32955@freescale.com (Huang Shijie)
Date: Thu, 21 Jul 2011 14:47:26 +0800
Subject: [PATCH v8 3/3] MTD : add GPMI-NAND driver in the config and Makefile
In-Reply-To: <1311230846-26437-1-git-send-email-b32955@freescale.com>
References: <1311230846-26437-1-git-send-email-b32955@freescale.com>
Message-ID: <1311230846-26437-4-git-send-email-b32955@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

add the GPMI-NAND driver in the relevant Kconfig and Makefile in the MTD.

Signed-off-by: Huang Shijie <b32955@freescale.com>
---
 drivers/mtd/nand/Kconfig            |   11 +++++++++++
 drivers/mtd/nand/Makefile           |    1 +
 drivers/mtd/nand/gpmi-nand/Makefile |    3 +++
 3 files changed, 15 insertions(+), 0 deletions(-)
 create mode 100644 drivers/mtd/nand/gpmi-nand/Makefile

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 4c34252..97a1350 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -423,6 +423,17 @@ config MTD_NAND_NANDSIM
 	  The simulator may simulate various NAND flash chips for the
 	  MTD nand layer.
 
+config MTD_NAND_GPMI_NAND
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
index 5745d83..b187f82 100644
--- a/drivers/mtd/nand/Makefile
+++ b/drivers/mtd/nand/Makefile
@@ -49,5 +49,6 @@ obj-$(CONFIG_MTD_NAND_BCM_UMI)		+= bcm_umi_nand.o nand_bcm_umi.o
 obj-$(CONFIG_MTD_NAND_MPC5121_NFC)	+= mpc5121_nfc.o
 obj-$(CONFIG_MTD_NAND_RICOH)		+= r852.o
 obj-$(CONFIG_MTD_NAND_JZ4740)		+= jz4740_nand.o
+obj-$(CONFIG_MTD_NAND_GPMI_NAND)	+= gpmi-nand/
 
 nand-objs := nand_base.o nand_bbt.o
diff --git a/drivers/mtd/nand/gpmi-nand/Makefile b/drivers/mtd/nand/gpmi-nand/Makefile
new file mode 100644
index 0000000..3a46248
--- /dev/null
+++ b/drivers/mtd/nand/gpmi-nand/Makefile
@@ -0,0 +1,3 @@
+obj-$(CONFIG_MTD_NAND_GPMI_NAND) += gpmi_nand.o
+gpmi_nand-objs += gpmi-nand.o
+gpmi_nand-objs += gpmi-lib.o
-- 
1.7.0.4
