From: festevam@gmail.com (Fabio Estevam)
Date: Sat, 16 Sep 2017 21:46:26 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_MUX_MMIO
Message-ID: <1505609186-21727-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

In order to get ADV7180 analog video decoder to probe on a Gateworks
GW51xx we need select CONFIG_MUX_MMIO, otherwise /dev/media node does
not get created.

Select CONFIG_MUX_MMIO, so that the ADV7180 driver can be correctly
probed.

Reported-by: Tim Harvey <tharvey@gateworks.com>
Suggested-by: Steve Longerbeam <slongerbeam@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 32acac9..addac53 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -365,6 +365,7 @@ CONFIG_PWM=y
 CONFIG_PWM_FSL_FTM=y
 CONFIG_PWM_IMX=y
 CONFIG_NVMEM_IMX_OCOTP=y
+CONFIG_MUX_MMIO=y
 CONFIG_EXT2_FS=y
 CONFIG_EXT2_FS_XATTR=y
 CONFIG_EXT2_FS_POSIX_ACL=y
-- 
2.7.4
