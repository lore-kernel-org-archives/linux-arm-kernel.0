From: mike@compulab.co.il (Mike Rapoport)
Date: Wed,  9 Mar 2011 16:31:19 +0200
Subject: [PATCH v2 3/3] ARM: tegra: update defconfig
In-Reply-To: <cover.1299681036.git.mike@compulab.co.il>
References: <cover.1299681036.git.mike@compulab.co.il>
Message-ID: <9bb699b7edf6bf50fe3680af99b4ff59fec03d3f.1299681036.git.mike@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Enable TPS6586x PMIC driver
* Enable RealTek 8169 used on TrimSlice
* Allow booting with root on NFS

Signed-off-by: Mike Rapoport <mike@compulab.co.il>
---
 arch/arm/configs/tegra_defconfig |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/tegra_defconfig b/arch/arm/configs/tegra_defconfig
index eb8c31e..8845f1c 100644
--- a/arch/arm/configs/tegra_defconfig
+++ b/arch/arm/configs/tegra_defconfig
@@ -44,6 +44,10 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_NET_KEY=y
 CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
 CONFIG_INET_ESP=y
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
@@ -70,7 +74,7 @@ CONFIG_APDS9802ALS=y
 CONFIG_ISL29003=y
 CONFIG_NETDEVICES=y
 CONFIG_DUMMY=y
-# CONFIG_NETDEV_1000 is not set
+CONFIG_R8169=y
 # CONFIG_NETDEV_10000 is not set
 # CONFIG_WLAN is not set
 # CONFIG_INPUT is not set
@@ -86,7 +90,9 @@ CONFIG_I2C=y
 # CONFIG_I2C_HELPER_AUTO is not set
 CONFIG_I2C_TEGRA=y
 CONFIG_SENSORS_LM90=y
-# CONFIG_MFD_SUPPORT is not set
+CONFIG_MFD_TPS6586X=y
+CONFIG_REGULATOR=y
+CONFIG_REGULATOR_TPS6586X=y
 # CONFIG_USB_SUPPORT is not set
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
@@ -108,6 +114,8 @@ CONFIG_EXT3_FS_SECURITY=y
 # CONFIG_DNOTIFY is not set
 CONFIG_VFAT_FS=y
 CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_EFI_PARTITION=y
 CONFIG_NLS_CODEPAGE_437=y
-- 
1.7.3.1
