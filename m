From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 21 Dec 2012 15:49:19 +0100
Subject: [PATCH v2 20/20] arm: mvebu: enable btmrvl driver in mvebu_defconfig
In-Reply-To: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1356101359-6054-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <1356101359-6054-21-git-send-email-thomas.petazzoni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Globalscale Mirabox platform, based on the Armada 370 from
Marvell, has a SD8787 Wireless/Bluetooth chip connected on the SDIO
interface. Now that the mvsdio has a Device Tree binding, and the
necessary Device Tree informations have been added at the SoC and
board level, let's enable the btmrvl driver for the Bluetooth part of
the SD8787 chip.

For now, the driver gets probed correctly, detects the device but
apparently fails to push the firmware to the device:

Bluetooth: vendor=0x2df, device=0x911a, class=255, fn=2
Bluetooth: FW failed to be active in time!
Bluetooth: Downloading firmware failed!
Bluetooth: vendor=0x2df, device=0x911b, class=255, fn=3
Bluetooth: FW failed to be active in time!
Bluetooth: Downloading firmware failed!

This will have to be investigated separately.

Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
---
 arch/arm/configs/mvebu_defconfig |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index 19f0c3d..f849ac3 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -24,6 +24,9 @@ CONFIG_ARM_APPENDED_DTB=y
 CONFIG_VFP=y
 CONFIG_NET=y
 CONFIG_INET=y
+CONFIG_BT=y
+CONFIG_BT_MRVL=y
+CONFIG_BT_MRVL_SDIO=y
 CONFIG_CFG80211=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_BLK_DEV_SD=y
-- 
1.7.9.5
