From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Jun 2018 09:34:02 -0300
Subject: [PATCH 1/2] ARM: imx_v6_v7_defconfig: Re-sync defconfig
Message-ID: <1529930043-6387-1-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Re-sync imx_v6_v7_defconfig by doing:
 
make savedefconfig
cp defconfig arch/arm/configs/imx_v6_v7_defconfig

CONFIG_BT_HCIUART_H4 option is selected via Kconfig logic.

CONFIG_SND_SOC_IMX_WM8962 no longer exists as the imx-wm8962 audio
machine layer has been removed.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f70507a..d14de86 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -81,7 +81,6 @@ CONFIG_CAN=y
 CONFIG_CAN_FLEXCAN=y
 CONFIG_BT=y
 CONFIG_BT_HCIUART=y
-CONFIG_BT_HCIUART_H4=y
 CONFIG_BT_HCIUART_LL=y
 CONFIG_CFG80211=y
 CONFIG_CFG80211_WEXT=y
@@ -282,7 +281,6 @@ CONFIG_SND_SOC_FSL_ASRC=y
 CONFIG_SND_IMX_SOC=y
 CONFIG_SND_SOC_PHYCORE_AC97=y
 CONFIG_SND_SOC_EUKREA_TLV320=y
-CONFIG_SND_SOC_IMX_WM8962=y
 CONFIG_SND_SOC_IMX_ES8328=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_SPDIF=y
-- 
2.7.4
