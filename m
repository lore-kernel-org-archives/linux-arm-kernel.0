From: horms+renesas@verge.net.au (Simon Horman)
Date: Thu, 17 Dec 2015 14:24:51 +0900
Subject: [PATCH 1/7] ARM: shmobile: defconfig: Enable CONFIG_PRINTK_TIME
In-Reply-To: <cover.1450315426.git.horms+renesas@verge.net.au>
References: <cover.1450315426.git.horms+renesas@verge.net.au>
Message-ID: <0d8587b49a445d11e497fbe296576e7ab7c54109.1450315426.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Geert Uytterhoeven <geert+renesas@glider.be>

Enable timestamps for kernel log output to improve debugging.
You can always use "dmesg -t" to strip the timestamps.

Don't specify CONFIG_LOG_BUF_SHIFT=16 while we're at it.  There's a
reason the default in Kconfig is higher ;-)

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Simon Horman <horms+renesas@verge.net.au>
---
 arch/arm/configs/shmobile_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 3aef019c0de7..e51f7a79c730 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -2,7 +2,6 @@ CONFIG_SYSVIPC=y
 CONFIG_NO_HZ=y
 CONFIG_IKCONFIG=y
 CONFIG_IKCONFIG_PROC=y
-CONFIG_LOG_BUF_SHIFT=16
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL_SYSCALL=y
@@ -199,6 +198,7 @@ CONFIG_NFS_V4_1=y
 CONFIG_ROOT_NFS=y
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_ISO8859_1=y
+CONFIG_PRINTK_TIME=y
 # CONFIG_ENABLE_WARN_DEPRECATED is not set
 # CONFIG_ENABLE_MUST_CHECK is not set
 # CONFIG_ARM_UNWIND is not set
-- 
2.1.4
