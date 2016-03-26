From: jlu@pengutronix.de (Jan Luebbe)
Date: Sat, 26 Mar 2016 12:28:26 +0100
Subject: [PATCH 2/2] ARM: multi_v5_defconfig: Enable recommended options for
 systemd
In-Reply-To: <1458991706-30109-1-git-send-email-jlu@pengutronix.de>
References: <1458991706-30109-1-git-send-email-jlu@pengutronix.de>
Message-ID: <1458991706-30109-2-git-send-email-jlu@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Enable FHANDLE, CGROUPS, BLK_DEV_BSG and DEVTMPFS as recommended by
systemd (which also matches the multi_v7 defconfig). Also enable IPV6,
which defaults to 'y' by now.

Signed-off-by: Jan Luebbe <jlu@pengutronix.de>
---
 arch/arm/configs/multi_v5_defconfig | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/multi_v5_defconfig b/arch/arm/configs/multi_v5_defconfig
index bb8d609..a822dd3 100644
--- a/arch/arm/configs/multi_v5_defconfig
+++ b/arch/arm/configs/multi_v5_defconfig
@@ -1,14 +1,15 @@
 CONFIG_SYSVIPC=y
+CONFIG_FHANDLE=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_LOG_BUF_SHIFT=19
+CONFIG_CGROUPS=y
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_PROFILING=y
 CONFIG_OPROFILE=y
 CONFIG_KPROBES=y
 CONFIG_MODULES=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_BLK_DEV_BSG is not set
 # CONFIG_ARCH_MULTI_V7 is not set
 CONFIG_ARCH_MVEBU=y
 CONFIG_MACH_KIRKWOOD=y
@@ -65,13 +66,14 @@ CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
-# CONFIG_IPV6 is not set
 CONFIG_NET_DSA=y
 CONFIG_NET_SWITCHDEV=y
 CONFIG_NET_PKTGEN=m
 CONFIG_CFG80211=y
 CONFIG_MAC80211=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_IMX_WEIM=y
 CONFIG_MTD=y
 CONFIG_MTD_CMDLINE_PARTS=y
-- 
2.1.4
