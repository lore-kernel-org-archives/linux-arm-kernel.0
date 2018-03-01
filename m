From: festevam@gmail.com (Fabio Estevam)
Date: Thu,  1 Mar 2018 16:08:56 -0300
Subject: [PATCH] ARM: imx_v6_v7_defconfig: Select CONFIG_SND_SOC_WM8962
 explicitly
Message-ID: <1519931336-9710-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Currently CONFIG_SND_SOC_WM8962 is selected via SND_SOC_IMX_WM8962
machine driver option.

SND_SOC_IMX_WM8962 will be removed in the next kernel cycle, so
select the codec driver directly so that it can still be used
by default via the generic fsl-asoc-card machine driver.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
The patch that removes SND_SOC_IMX_WM8962 is in linux-next:
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?h=next-20180301&id=790d631dcfec6b073b04bb6809bce4c09baf198a

 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 9d9c729..3a30843 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -284,6 +284,7 @@ CONFIG_SND_SOC_AC97_CODEC=y
 CONFIG_SND_SOC_CS42XX8_I2C=y
 CONFIG_SND_SOC_TLV320AIC3X=y
 CONFIG_SND_SOC_WM8960=y
+CONFIG_SND_SOC_WM8962=y
 CONFIG_SND_SIMPLE_CARD=y
 CONFIG_HID_MULTITOUCH=y
 CONFIG_USB=y
-- 
2.7.4
