From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 12 Aug 2013 08:55:53 -0300
Subject: [PATCH 2/2] ARM: imx: Re-select CONFIG_SND_SOC_IMX_MC13783 option
In-Reply-To: <1376308553-2824-1-git-send-email-festevam@gmail.com>
References: <1376308553-2824-1-git-send-email-festevam@gmail.com>
Message-ID: <1376308553-2824-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@freescale.com>

Commit 02502da45 (ASoC: imx-mc13783: Depend on ARCH_ARM) caused the selection of
CONFIG_SND_SOC_IMX_MC13783 to be impossible due to a wrong dependency, which
caused CONFIG_SND_SOC_IMX_MC13783 to be removed after the defconfigs cleanups.

The original selection problem has been fixed by 9f19de649f (ASoC: imx-mc13783:
Make SND_SOC_IMX_MC13783 visible again), so it is possible to select 
CONFIG_SND_SOC_IMX_MC13783 again as originally done.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---

 arch/arm/configs/imx_v4_v5_defconfig | 1 +
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 6cc94a7..e958ebe 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -146,6 +146,7 @@ CONFIG_SND_SOC_MX27VIS_AIC32X4=y
 CONFIG_SND_SOC_PHYCORE_AC97=y
 CONFIG_SND_SOC_EUKREA_TLV320=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
+CONFIG_SND_SOC_IMX_MC13783=y
 CONFIG_USB_HID=m
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index c2c024f..402f282 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -188,6 +188,7 @@ CONFIG_SND_SOC_PHYCORE_AC97=y
 CONFIG_SND_SOC_EUKREA_TLV320=y
 CONFIG_SND_SOC_IMX_WM8962=y
 CONFIG_SND_SOC_IMX_SGTL5000=y
+CONFIG_SND_SOC_IMX_MC13783=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
-- 
1.8.1.2
