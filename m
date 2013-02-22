From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Fri, 22 Feb 2013 15:10:22 -0300
Subject: [PATCH] ARM: mxs_defconfig: Select CONFIG_MMC_UNSAFE_RESUME
Message-ID: <1361556622-2550-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

PM subsystem treats mmc card as removed during suspend.

If MMC is used to store the root file system, it is better to tell the kernel
not to treat it as a removable media, so select CONFIG_MMC_UNSAFE_RESUME for
such purpose.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/mxs_defconfig |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mxs_defconfig b/arch/arm/configs/mxs_defconfig
index fbbc5bb..6715538 100644
--- a/arch/arm/configs/mxs_defconfig
+++ b/arch/arm/configs/mxs_defconfig
@@ -121,6 +121,7 @@ CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_USB_STORAGE=y
 CONFIG_USB_MXS_PHY=y
 CONFIG_MMC=y
+CONFIG_MMC_UNSAFE_RESUME=y
 CONFIG_MMC_MXS=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=y
-- 
1.7.9.5
