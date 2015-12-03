From: dinguyen@opensource.altera.com (dinguyen at opensource.altera.com)
Date: Thu, 3 Dec 2015 16:22:12 -0600
Subject: [PATCH] arm: socfpga_defconfig: enable USB dual-role and cleanup
Message-ID: <1449181332-5512-1-git-send-email-dinguyen@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@opensource.altera.com>

Enable USB OTG dual-role and a bit of clean up by using make savedefconfig.

Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
---
 arch/arm/configs/socfpga_defconfig | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 8128b93e..f7f4e2e 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -36,7 +36,6 @@ CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
-CONFIG_IPV6=y
 CONFIG_NETWORK_PHY_TIMESTAMPING=y
 CONFIG_VLAN_8021Q=y
 CONFIG_VLAN_8021Q_GVRP=y
@@ -57,7 +56,6 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_STMMAC_ETH=y
-CONFIG_DWMAC_SOCFPGA=y
 CONFIG_MICREL_PHY=y
 CONFIG_INPUT_EVDEV=y
 # CONFIG_SERIO_SERPORT is not set
@@ -83,7 +81,8 @@ CONFIG_REGULATOR=y
 CONFIG_REGULATOR_FIXED_VOLTAGE=y
 CONFIG_USB=y
 CONFIG_USB_DWC2=y
-CONFIG_USB_DWC2_HOST=y
+CONFIG_NOP_USB_XCEIV=y
+CONFIG_USB_GADGET=y
 CONFIG_MMC=y
 CONFIG_MMC_DW=y
 CONFIG_FPGA=y
@@ -92,7 +91,6 @@ CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
 CONFIG_EXT3_FS=y
-CONFIG_EXT4_FS=y
 CONFIG_VFAT_FS=y
 CONFIG_NTFS_FS=y
 CONFIG_NTFS_RW=y
-- 
2.6.2
