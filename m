From: marc.w.gonzalez@free.fr (Marc Gonzalez)
Date: Fri, 9 Nov 2018 02:02:18 +0100
Subject: [PATCH v3 4/9] arm64: defconfig: Drop USB_ULPI_BUS and
 USB_CHIPIDEA_ULPI
In-Reply-To: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
References: <49a5d199-4eeb-a7c2-b539-13356162547f@free.fr>
Message-ID: <a5a9193c-018a-8d52-7b62-2743db048a69@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Commit a930d8bd94d8 ("usb: chipidea: Always build ULPI code") made
USB_CHIPIDEA select USB_ULPI_BUS, and removed USB_CHIPIDEA_ULPI.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
Signed-off-by: Marc Gonzalez <marc.w.gonzalez@free.fr>
---
 arch/arm64/configs/defconfig | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 58741c07a6ef..6fe418d72337 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -528,7 +528,6 @@ CONFIG_USB_DWC2=y
 CONFIG_USB_CHIPIDEA=y
 CONFIG_USB_CHIPIDEA_UDC=y
 CONFIG_USB_CHIPIDEA_HOST=y
-CONFIG_USB_CHIPIDEA_ULPI=y
 CONFIG_USB_ISP1760=y
 CONFIG_USB_HSIC_USB3503=y
 CONFIG_NOP_USB_XCEIV=y
@@ -536,7 +535,6 @@ CONFIG_USB_ULPI=y
 CONFIG_USB_GADGET=y
 CONFIG_USB_RENESAS_USBHS_UDC=m
 CONFIG_USB_RENESAS_USB3=m
-CONFIG_USB_ULPI_BUS=y
 CONFIG_MMC=y
 CONFIG_MMC_BLOCK_MINORS=32
 CONFIG_MMC_ARMMMCI=y
-- 
2.8.2
