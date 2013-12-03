From: olof@lixom.net (Olof Johansson)
Date: Mon,  2 Dec 2013 18:40:50 -0800
Subject: [PATCH] ARM: sunxi_defconfig: enable NFS, TMPFS,
 PRINTK_TIME and nfsroot support
Message-ID: <1386038450-15165-1-git-send-email-olof@lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This enables a few more options on the sunxi defconfigs such that I can
use nfsroot to boot them (there is no local storage support yet). It
also enables PRINTK_TIME and tmpfs since it's a common distro requirement.

Signed-off-by: Olof Johansson <olof@lixom.net>
---

Maxime,

I'll apply this to our fixes branch for 3.13 so I can start using it on
the Allwinner machines I have in the test farm here.


-Olof

 arch/arm/configs/sunxi_defconfig |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/arm/configs/sunxi_defconfig b/arch/arm/configs/sunxi_defconfig
index d57a85b..3e2259b 100644
--- a/arch/arm/configs/sunxi_defconfig
+++ b/arch/arm/configs/sunxi_defconfig
@@ -12,6 +12,9 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
 # CONFIG_INET_XFRM_MODE_TRANSPORT is not set
 # CONFIG_INET_XFRM_MODE_TUNNEL is not set
 # CONFIG_INET_XFRM_MODE_BEET is not set
@@ -58,4 +61,8 @@ CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_COMMON_CLK_DEBUG=y
 # CONFIG_IOMMU_SUPPORT is not set
+CONFIG_TMPFS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 CONFIG_NLS=y
+CONFIG_PRINTK_TIME=y
-- 
1.7.10.4
