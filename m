From: horms+renesas@verge.net.au (Simon Horman)
Date: Fri, 21 Feb 2014 15:12:41 +0900
Subject: [PATCH 5/5] ARM: shmobile: r7s72100: update defconfig for I2C usage
In-Reply-To: <cover.1392962286.git.horms+renesas@verge.net.au>
References: <cover.1392962286.git.horms+renesas@verge.net.au>
Message-ID: <7573e89ba1fcbe492c52d5b1e72fcf5d23da21d1.1392962286.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Wolfram Sang <wsa@sang-engineering.com>

Select the correct I2C driver and activate EEPROM support to have a
slave device for testing. Also activate i2c-dev, so i2c-tools will work.

Signed-off-by: Wolfram Sang <wsa@sang-engineering.com>
Acked-by: Magnus Damm <damm@opensource.se>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/genmai_defconfig | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/genmai_defconfig b/arch/arm/configs/genmai_defconfig
index 5ee6ac0..d238faf 100644
--- a/arch/arm/configs/genmai_defconfig
+++ b/arch/arm/configs/genmai_defconfig
@@ -52,6 +52,7 @@ CONFIG_IP_PNP_DHCP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
+CONFIG_EEPROM_AT24=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_CORE is not set
 # CONFIG_NET_VENDOR_ARC is not set
@@ -80,7 +81,8 @@ CONFIG_SERIAL_SH_SCI=y
 CONFIG_SERIAL_SH_SCI_NR_UARTS=10
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 # CONFIG_HW_RANDOM is not set
-CONFIG_I2C_SH_MOBILE=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_RIIC=y
 CONFIG_SPI=y
 CONFIG_SPI_RSPI=y
 # CONFIG_HWMON is not set
-- 
1.8.5.2
