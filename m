From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 25 Jun 2018 09:34:03 -0300
Subject: [PATCH 2/2] ARM: imx_v6_v7_defconfig: Select ULPI support
In-Reply-To: <1529930043-6387-1-git-send-email-festevam@gmail.com>
References: <1529930043-6387-1-git-send-email-festevam@gmail.com>
Message-ID: <1529930043-6387-2-git-send-email-festevam@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Fabio Estevam <fabio.estevam@nxp.com>

Select CONFIG_USB_CHIPIDEA_ULPI and CONFIG_USB_ULPI_BUS so that
USB ULPI can be functional on some boards like imx51-babbge.

This fixes a kernel hang in 4.18-rc1 on i.mx51-babbage when
the bootloader does not initialize USB.

Suggested-by: Andrey Smirnov <andrew.smirnov@gmail.com>
Signed-off-by: Fabio Estevam <fabio.estevam@nxp.com>
---
 arch/arm/configs/imx_v6_v7_defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/configs/imx_v6_v7_defconfig b/arch/arm/configs/imx_v6_v7_defconfig
index d14de86..2da678c 100644
--- a/arch/arm/configs/imx_v6_v7_defconfig
+++ b/arch/arm/configs/imx_v6_v7_defconfig
@@ -300,6 +300,7 @@ CONFIG_USB_STORAGE=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
+CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_USB_SERIAL=m
 CONFIG_USB_SERIAL_GENERIC=y
 CONFIG_USB_SERIAL_FTDI_SIO=m
@@ -336,6 +337,7 @@ CONFIG_USB_GADGETFS=m
 CONFIG_USB_FUNCTIONFS=m
 CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
+CONFIG_USB_ULPI_BUS=y
 CONFIG_MMC=y
 CONFIG_MMC_SDHCI=y
 CONFIG_MMC_SDHCI_PLTFM=y
-- 
2.7.4
