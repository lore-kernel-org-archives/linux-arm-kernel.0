From: bgolaszewski@baylibre.com (Bartosz Golaszewski)
Date: Mon, 14 Nov 2016 18:32:04 +0100
Subject: [PATCH 2/2] ARM: davinci_all_defconfig: enable the mstpri and ddrctl
 drivers
In-Reply-To: <1479144724-14231-1-git-send-email-bgolaszewski@baylibre.com>
References: <1479144724-14231-1-git-send-email-bgolaszewski@baylibre.com>
Message-ID: <1479144724-14231-3-git-send-email-bgolaszewski@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

With the da8xx memory controller and master peripheral priority
drivers merged and corresponding device tree changes in place we can
now enable appropriate options by default.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/configs/davinci_all_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index b5e978f..f814f01 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -56,6 +56,7 @@ CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_FW_LOADER is not set
+CONFIG_DA8XX_MSTPRI=y
 CONFIG_MTD=m
 CONFIG_MTD_BLOCK=m
 CONFIG_MTD_CFI=m
@@ -187,6 +188,7 @@ CONFIG_DMADEVICES=y
 CONFIG_TI_EDMA=y
 CONFIG_MEMORY=y
 CONFIG_TI_AEMIF=m
+CONFIG_DA8XX_DDRCTL=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT3_FS=y
 CONFIG_XFS_FS=m
-- 
2.9.3
