From: dinguyen@altera.com (dinguyen at altera.com)
Date: Wed, 17 Jul 2013 18:10:23 -0500
Subject: [PATCH 4/4] arm: socfpga: Add support for SD/MMC and ethernet to
 defconfig
In-Reply-To: <1374102623-4154-1-git-send-email-dinguyen@altera.com>
References: <1374102623-4154-1-git-send-email-dinguyen@altera.com>
Message-ID: <1374102623-4154-5-git-send-email-dinguyen@altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Dinh Nguyen <dinguyen@altera.com>

Update the socfpga_defconfig to include dw_mmc driver and Micrel PHY.
Also enable EXT3 and NFS FS support.

Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
CC: Arnd Bergmann <arnd@arndb.de>
CC: Olof Johansson <olof@lixom.net>
Cc: Rob Herring <rob.herring@calxeda.com>
Cc: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Pavel Machek <pavel@denx.de>
Cc: Jack Mitchell <jack.mitchell@dbbroadcast.co.uk>
---
 arch/arm/configs/socfpga_defconfig |    8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/arm/configs/socfpga_defconfig b/arch/arm/configs/socfpga_defconfig
index 4e1ce21..dcca3a1 100644
--- a/arch/arm/configs/socfpga_defconfig
+++ b/arch/arm/configs/socfpga_defconfig
@@ -52,6 +52,7 @@ CONFIG_BLK_DEV_SD=y
 # CONFIG_SCSI_LOWLEVEL is not set
 CONFIG_NETDEVICES=y
 CONFIG_STMMAC_ETH=y
+CONFIG_MICREL_PHY=y
 # CONFIG_STMMAC_PHY_ID_ZERO_WORKAROUND is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_SERIO_SERPORT is not set
@@ -66,6 +67,9 @@ CONFIG_SERIAL_8250_DW=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
+CONFIG_EXT3_FS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 # CONFIG_DNOTIFY is not set
 # CONFIG_INOTIFY_USER is not set
 CONFIG_VFAT_FS=y
@@ -82,3 +86,7 @@ CONFIG_DEBUG_INFO=y
 CONFIG_ENABLE_DEFAULT_TRACERS=y
 CONFIG_DEBUG_USER=y
 CONFIG_XZ_DEC=y
+CONFIG_MMC=y
+CONFIG_MMC_DW=y
+CONFIG_MMC_DW_PLTFM=y
+CONFIG_MMC_DW_SOCFPGA=y
-- 
1.7.9.5
