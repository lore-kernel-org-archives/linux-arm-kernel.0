From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 30 Jan 2014 13:04:11 -0200
Subject: [PATCH 1/2] ARM: imx_v4_v5_defconfig: Select CONFIG_MMC_UNSAFE_RESUME
Message-ID: <1391094252-10599-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PM subsystem treats mmc card as removed during suspend.
    
If MMC is used to store the root file system, it is better to tell the kernel
not to treat it as a removable media, so select CONFIG_MMC_UNSAFE_RESUME for
such purpose.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v4_v5_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v4_v5_defconfig b/arch/arm/configs/imx_v4_v5_defconfig
index 6309ee5..f1aeb7d 100644
--- a/arch/arm/configs/imx_v4_v5_defconfig
+++ b/arch/arm/configs/imx_v4_v5_defconfig
@@ -154,6 +154,7 @@ CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_MXC=y
 CONFIG_MMC=y
+CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
-- 
1.8.1.2
