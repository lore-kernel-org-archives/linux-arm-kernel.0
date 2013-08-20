From: fathi.boudra@linaro.org (Fathi Boudra)
Date: Wed, 21 Aug 2013 00:02:41 +0300
Subject: [PATCH 1/3] ARM: vexpress_defconfig: Enable and automount devtmpfs
 filesystem
In-Reply-To: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
References: <1377032563-4502-1-git-send-email-fathi.boudra@linaro.org>
Message-ID: <1377032563-4502-2-git-send-email-fathi.boudra@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

udev no longer creates device nodes under /dev and it has to be managed
by the kernel devtmpfs filesystem.

This means that a kernel built with the current config will not boot on
a system with a recent udev:

mount: mounting udev on /dev failed: No such device
W: devtmpfs not available, falling back to tmpfs for /dev

Also, it is good to have /dev automatically mounted since some
non-initramfs based setups assumes this and don't manually mount it.

Signed-off-by: Fathi Boudra <fathi.boudra@linaro.org>
---
 arch/arm/configs/vexpress_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/vexpress_defconfig b/arch/arm/configs/vexpress_defconfig
index f2de51f..3f970f1 100644
--- a/arch/arm/configs/vexpress_defconfig
+++ b/arch/arm/configs/vexpress_defconfig
@@ -45,6 +45,8 @@ CONFIG_IP_PNP_BOOTP=y
 # CONFIG_IPV6 is not set
 # CONFIG_WIRELESS is not set
 CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_DEVTMPFS=y
+CONFIG_DEVTMPFS_MOUNT=y
 CONFIG_MTD=y
 CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
-- 
1.8.1.2
