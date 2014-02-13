From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 13 Feb 2014 17:04:35 +0900
Subject: [PATCH 3/4] ARM: shmobile: koelsch defconfig: Enable RSPI and
 MTD_M25P80
In-Reply-To: <cover.1392276997.git.horms+renesas@verge.net.au>
References: <cover.1392276997.git.horms+renesas@verge.net.au>
Message-ID: <201bd5ddcd9f11bb3942a062f0e907c3edc61f87.1392276997.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@linux-m68k.org>

This enables support for the Spansion s25fl512s SPI FLASH on QSPI.

Signed-off-by: Geert Uytterhoeven <geert+renesas@linux-m68k.org>
Acked-by: Magnus Damm <damm@opensource.se>
[horms+renesas at verge.net.au: resolved conflict]
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/koelsch_defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index c3b3c9d..9561139 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -40,6 +40,8 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
 CONFIG_SATA_RCAR=y
+CONFIG_MTD=y
+CONFIG_MTD_M25P80=y
 CONFIG_NETDEVICES=y
 # CONFIG_NET_VENDOR_ARC is not set
 # CONFIG_NET_CADENCE is not set
@@ -64,6 +66,8 @@ CONFIG_SERIAL_SH_SCI_NR_UARTS=20
 CONFIG_SERIAL_SH_SCI_CONSOLE=y
 CONFIG_I2C=y
 CONFIG_I2C_RCAR=y
+CONFIG_SPI=y
+CONFIG_SPI_RSPI=y
 # CONFIG_HWMON is not set
 CONFIG_THERMAL=y
 CONFIG_RCAR_THERMAL=y
-- 
1.8.5.2
