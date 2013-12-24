From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue, 24 Dec 2013 15:03:37 +0900
Subject: [PATCH 4/7] ARM: shmobile: Koelsch: enable Ether in defconfig
In-Reply-To: <cover.1387854925.git.horms+renesas@verge.net.au>
References: <cover.1387854925.git.horms+renesas@verge.net.au>
Message-ID: <9b408ca5885a46a0940aaf88be203b595c9aad85.1387854925.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>

Enable the Ether driver in 'koelsch_defconfig' along with DHCP autoconfiguration
and NFS root.

Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/koelsch_defconfig | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm/configs/koelsch_defconfig b/arch/arm/configs/koelsch_defconfig
index 825c16d..c59eab1 100644
--- a/arch/arm/configs/koelsch_defconfig
+++ b/arch/arm/configs/koelsch_defconfig
@@ -29,7 +29,27 @@ CONFIG_VFP=y
 CONFIG_NEON=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_PM_RUNTIME=y
+CONFIG_NET=y
+CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_NETDEVICES=y
+# CONFIG_NET_VENDOR_ARC is not set
+# CONFIG_NET_CADENCE is not set
+# CONFIG_NET_VENDOR_BROADCOM is not set
+# CONFIG_NET_VENDOR_CIRRUS is not set
+# CONFIG_NET_VENDOR_FARADAY is not set
+# CONFIG_NET_VENDOR_INTEL is not set
+# CONFIG_NET_VENDOR_MARVELL is not set
+# CONFIG_NET_VENDOR_MICREL is not set
+# CONFIG_NET_VENDOR_NATSEMI is not set
+CONFIG_SH_ETH=y
+# CONFIG_NET_VENDOR_SEEQ is not set
+# CONFIG_NET_VENDOR_SMSC is not set
+# CONFIG_NET_VENDOR_STMICRO is not set
+# CONFIG_NET_VENDOR_VIA is not set
+# CONFIG_NET_VENDOR_WIZNET is not set
 # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_LEGACY_PTYS is not set
@@ -49,6 +69,8 @@ CONFIG_LEDS_CLASS=y
 CONFIG_TMPFS=y
 CONFIG_CONFIGFS_FS=y
 # CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_ARM_UNWIND is not set
-- 
1.8.4
