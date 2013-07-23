From: fabio.estevam@freescale.com (Fabio Estevam)
Date: Tue, 23 Jul 2013 14:02:06 -0300
Subject: [PATCH] ARM: multi_v7_defconfig: Select USB chipidea driver
Message-ID: <1374598926-23761-1-git-send-email-fabio.estevam@freescale.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

CONFIG_USB_EHCI_MXC selects the old i.mx USB driver, which does not support 
device tree.

Select the USB chipidea driver instead, so that USB can be functional on i.mx.

Signed-off-by: Fabio Estevam <fabio.estevam@freescale.com>
---
 arch/arm/configs/multi_v7_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index fe0bdc3..ade8328 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -111,11 +111,12 @@ CONFIG_FB_SIMPLE=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
 CONFIG_USB_EHCI_HCD=y
-CONFIG_USB_EHCI_MXC=y
 CONFIG_USB_EHCI_TEGRA=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
 CONFIG_USB_ISP1760_HCD=y
 CONFIG_USB_STORAGE=y
+CONFIG_USB_CHIPIDEA=y
+CONFIG_USB_CHIPIDEA_HOST=y
 CONFIG_AB8500_USB=y
 CONFIG_NOP_USB_XCEIV=y
 CONFIG_OMAP_USB2=y
-- 
1.8.1.2
