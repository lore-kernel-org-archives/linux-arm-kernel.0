From: atull@opensource.altera.com (Alan Tull)
Date: Tue, 1 Nov 2016 18:54:44 -0500
Subject: [PATCH] ARM: socfpga: updates for socfpga_defconfig
Message-ID: <1478044484-2331-1-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the following in the
socfpga_defconfig:

+CONFIG_OF_OVERLAY=y
  Enable support for Device Tree Overlays

+CONFIG_FPGA_REGION=y
  Enable device tree overlay support for FPGA
  programming

+CONFIG_FPGA_MGR_SOCFPGA_A10=y
  Enable partial reconfiguration for Altera
  Arria 10 FPGA

+CONFIG_FPGA_BRIDGE=y
  Enable the FPGA Bridges framework

+CONFIG_SOCFPGA_FPGA_BRIDGE=y
  Enable support for SoCFPGA hardware
  bridges

+CONFIG_ALTERA_FREEZE_BRIDGE=y
  Enable support for the Altera Soft IP
  Freeze bridges

Signed-off-by: Alan Tull <atull@opensource.altera.com>
---
 arch/arm/configs/socfpga_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index f5b9bc5..18d3ec1 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -54,6 +54,7 @@ CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_SPI_NOR=y
 CONFIG_SPI_CADENCE_QUADSPI=y
+CONFIG_OF_OVERLAY=y
 CONFIG_BLK_DEV_RAM=y
 CONFIG_BLK_DEV_RAM_COUNT=2
 CONFIG_BLK_DEV_RAM_SIZE=8192
@@ -105,7 +106,12 @@ CONFIG_DMADEVICES=y
 CONFIG_PL330_DMA=y
 CONFIG_DMATEST=m
 CONFIG_FPGA=y
+CONFIG_FPGA_REGION=y
 CONFIG_FPGA_MGR_SOCFPGA=y
+CONFIG_FPGA_MGR_SOCFPGA_A10=y
+CONFIG_FPGA_BRIDGE=y
+CONFIG_SOCFPGA_FPGA_BRIDGE=y
+CONFIG_ALTERA_FREEZE_BRIDGE=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
1.9.1
