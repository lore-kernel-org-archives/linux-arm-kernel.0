From: festevam@gmail.com (Fabio Estevam)
Date: Wed,  3 Oct 2018 11:13:49 -0300
Subject: [PATCH v2 2/6] ARM: imx_v6_v7_defconfig: Remove unneeded options
In-Reply-To: <1538576033-23415-1-git-send-email-festevam@gmail.com>
References: <1538576033-23415-1-git-send-email-festevam@gmail.com>
Message-ID: <1538576033-23415-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Remove the following unneeded config options:

- CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS have been removed
since commit a930d8bd94d8d ("usb: chipidea: Always build ULPI code")

- CONFIG_DEBUG_FS is selected by default.

Signed-off-by: Fabio Estevam <festevam@gmail.com>
---
Changes since v1:
- Split into a new patch the config options that were removed

 arch/arm/configs/imx_v6_v7_defconfig | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index f548fd5..e0c6b7c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -309,7 +309,6 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
-CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_FTDI_SIO=m
@@ -346,7 +345,6 @@ CONFIG_USB_GADGETFS=m
 CONFIG_USB_FUNCTIONFS=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
-CONFIG_USB_ULPI_BUS=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
@@ -428,7 +426,6 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=m
 CONFIG_NLS_UTF8=y
-CONFIG_DEBUG_FS=y
 CONFIG_SECURITYFS=y
 CONFIG_CRYPTO_DEV_FSL_CAAM=y
 CONFIG_CRYPTO_DEV_SAHARA=y
-- 
2.7.4
