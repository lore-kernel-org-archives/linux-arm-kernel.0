From: eric@anholt.net (Eric Anholt)
Date: Thu, 31 Mar 2016 17:30:43 -0700
Subject: [PATCH 4/4] ARM: bcm2835: Enable NFS root support.
In-Reply-To: <1459470643-9070-1-git-send-email-eric@anholt.net>
References: <1459470643-9070-1-git-send-email-eric@anholt.net>
Message-ID: <1459470643-9070-4-git-send-email-eric@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is also present in multi_v7_defconfig, and means that I can test
the pi1 with the 2835 defconfig in my normal environment.

Signed-off-by: Eric Anholt <eric@anholt.net>
---
 arch/arm/configs/bcm2835_defconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/arm/configs/bcm2835_defconfig b/arch/arm/configs/bcm2835_defconfig
index 896500f..79de828 100644
--- a/arch/arm/configs/bcm2835_defconfig
+++ b/arch/arm/configs/bcm2835_defconfig
@@ -43,6 +43,8 @@ CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
 CONFIG_INET=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
 CONFIG_NETWORK_SECMARK=y
 CONFIG_NETFILTER=y
 CONFIG_CFG80211=y
@@ -122,6 +124,7 @@ CONFIG_TMPFS=y
 CONFIG_TMPFS_POSIX_ACL=y
 # CONFIG_MISC_FILESYSTEMS is not set
 CONFIG_NFS_FS=y
+CONFIG_ROOT_NFS=y
 CONFIG_NFSD=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ASCII=y
-- 
2.7.0
