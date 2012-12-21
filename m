From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Dec 2012 15:49:18 +0100
Subject: [PATCH v2 19/20] arm: mvebu: enable mwifiex driver in mvebu_defconfig
In-Reply-To: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1356101359-6054-20-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Globalscale Mirabox platform, based on the Armada 370 from
Marvell, has a SD8787 Wireless chip connected on the SDIO
interface. Now that the mvsdio has a Device Tree binding, and the
necessary Device Tree informations have been added at the SoC and
board level, let's enable the mwifiex driver for the Wireless part of
the SD8787 chip.

For now, the driver gets probed correctly, detects a device and shows
the network interfaces. However, scanning Wifi networks doesn't work
for now, with a 'CMD_RESP: cmd 0x6 error, result=0x1' message. This
will have to be investigated separately.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 14cb45c..19f0c3d 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -24,6 +24,7 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_VFP=y
 CONFIG_NET=y
 CONFIG_INET=y
+CONFIG_CFG80211=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_SD=y
 CONFIG_ATA=y
@@ -31,6 +32,8 @@ CONFIG_SATA_MV=y
 CONFIG_NETDEVICES=y
 CONFIG_MVNETA=y
 CONFIG_MARVELL_PHY=y
+CONFIG_MWIFIEX=y
+CONFIG_MWIFIEX_SDIO=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 CONFIG_SERIAL_OF_PLATFORM=y
-- 
1.7.9.5
