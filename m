From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Thu, 30 Jan 2014 13:04:12 -0200
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Select CONFIG_MMC_UNSAFE_RESUME
In-Reply-To: <1391094252-10599-1-git-send-email-fabio.estevam@freescale.com>
References: <1391094252-10599-1-git-send-email-fabio.estevam@freescale.com>
Message-ID: <1391094252-10599-2-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PM subsystem treats mmc card as removed during suspend.
    
If MMC is used to store the root file system, it is better to tell the kernel
not to treat it as a removable media, so select CONFIG_MMC_UNSAFE_RESUME for
such purpose.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index 82ab3cc..7b76794 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -215,6 +215,7 @@ CONFIG_USB_GADGET=y
 CONFIG_USB_ETH=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_MMC=y
+CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
 CONFIG_MMC_SDHCI_ESDHC_IMX=y
-- 
1.8.1.2
