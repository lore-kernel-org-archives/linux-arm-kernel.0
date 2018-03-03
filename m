From: festevam@gmail.com (Fabio Estevam)
Date: Sat,  3 Mar 2018 17:05:48 -0300
Subject: [PATCH 2/2] ARM: imx_v4_v5_defconfig: Use the generic fsl-asoc-card
 driver
In-Reply-To: <1520107548-31619-1-git-send-email-festevam@gmail.com>
References: <1520107548-31619-1-git-send-email-festevam@gmail.com>
Message-ID: <1520107548-31619-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

fsl-asoc-card machine driver also supports sgtl5000, so use it favor
of the imx-sgtl5000 machine driver, which will be probably be removed
in the future.

Tested on a imx25-pdk board.

Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v4_v5_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 893d0a0..054591d 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -130,8 +130,9 @@ CONFIG_SND_IMX_SOC=y
 CONFIG_SND_SOC_MX27VIS_AIC32X4=y
 CONFIG_SND_SOC_PHYCORE_AC97=y
 CONFIG_SND_SOC_EUKREA_TLV320=y
-CONFIG_SND_SOC_IMX_SGTL5000=y
 CONFIG_SND_SOC_IMX_MC13783=y
+CONFIG_SND_SOC_FSL_ASOC_CARD=y
+CONFIG_SND_SOC_SGTL5000=y
 CONFIG_USB_HID=m
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
-- 
2.7.4
