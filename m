From: yibin.gong@nxp.com (Robin Gong)
Date: Fri, 13 Jul 2018 21:08:47 +0800
Subject: [PATCH v2 3/3] ARM: configs: imx_v6_v7_defconfig: add DMATEST support
In-Reply-To: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
References: <1531487327-21879-1-git-send-email-yibin.gong@nxp.com>
Message-ID: <1531487327-21879-4-git-send-email-yibin.gong@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Add DMATEST support and remove invalid options, such as
CONFIG_BT_HCIUART_H4 is default enabled and CONFIG_SND_SOC_IMX_WM8962
is out of date and not appear in any config file. Please refer to
Documentation/driver-api/dmaengine/dmatest.rst to test MEMCPY feature
of imx-sdma.

Signed-off-by: Robin Gong <yibin.gong@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index e381d05..f28d4d9 100644
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
@@ -371,6 +369,7 @@ CONFIG_DMADEVICES=y
 CONFIG_FSL_EDMA=y
 CONFIG_IMX_SDMA=y
 CONFIG_MXS_DMA=y
+CONFIG_DMATEST=m
 CONFIG_STAGING=y
 CONFIG_STAGING_MEDIA=y
 CONFIG_VIDEO_IMX_MEDIA=y
-- 
2.7.4
