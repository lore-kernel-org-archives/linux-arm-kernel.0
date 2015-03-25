From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Wed, 25 Mar 2015 20:08:24 +0100
Subject: [PATCH v2 1/1] ARM: exynos_defconfig: Enable options to mount a
 rootfs via NFS
Message-ID: <1427310504-1505-1-git-send-email-javier.martinez@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch enables the options to mount a rootfs over NFS and also support
for automatic configuration of IP addresses during boot as needed by NFS.

Signed-off-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
---

Changes since v1:
 - Found a typo in the changelog after posting the patch. Sorry for the noise.

 arch/arm/configs/exynos_defconfig | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
index 72a4fffd603e..02be4c072497 100644
--- a/arch/arm/configs/exynos_defconfig
+++ b/arch/arm/configs/exynos_defconfig
@@ -36,6 +36,10 @@ CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_NET_KEY=y
 CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
 CONFIG_WIRELESS=y
 CONFIG_CFG80211=y
 CONFIG_MWIFIEX=y
@@ -206,6 +210,8 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 CONFIG_CRAMFS=y
 CONFIG_ROMFS_FS=y
+CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
-- 
2.1.4
