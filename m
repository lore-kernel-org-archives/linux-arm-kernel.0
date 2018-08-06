From: yibin.gong@nxp.com (Robin Gong)
Date: Tue,  7 Aug 2018 02:20:55 +0800
Subject: [PATCH v1] ARM: arm: configs: imx_v6_v7: add
 CONFIG_FW_LOADER_USER_HELPER
Message-ID: <1533579655-5498-1-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

To support loading sdma firmware automatically from rootfs, enable
CONFIG_FW_LOADER_USER_HELPER/CONFIG_FW_LOADER_USER_HELPER_FALLBACK.
Please get sdma firmware from below link and put it into
rootfs entry -- /lib/firmware/imx/sdma/:
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/tree/imx/sdma

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e2c1276..5e35d7e2 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -90,6 +90,8 @@ CONFIG_RFKILL_INPUT=y
 CONFIG_DEVTMPFS=y
 CONFIG_DEVTMPFS_MOUNT=y
 # CONFIG_STANDALONE is not set
+CONFIG_FW_LOADER_USER_HELPER=y
+CONFIG_FW_LOADER_USER_HELPER_FALLBACK=y
 CONFIG_CMA_SIZE_MBYTES=64
 CONFIG_IMX_WEIM=y
 CONFIG_CONNECTOR=y
-- 
2.7.4
