From: jagannadh.teki@gmail.com (Jagan Teki)
Date: Wed,  6 Dec 2017 23:19:58 +0530
Subject: [PATCH 1/2] arm64: defconfig: enable MUSB HDRC along with Allwinner
 glue
Message-ID: <1512582598-24806-1-git-send-email-jagan@amarulasolutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Allwinner SoCs typically have a Mentor Graphics Inventra MUSB
dual role controller for USB OTG. This is need for verifying
gadget functions, so enable them by default.

Tested 'otg' mode with mass storage function.

Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
---
 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 6356c6d..78f669a 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -429,6 +429,8 @@ CONFIG_USB_OHCI_EXYNOS=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
 CONFIG_USB_RENESAS_USBHS=m
 CONFIG_USB_STORAGE=y
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_MUSB_SUNXI=y
 CONFIG_USB_DWC3=y
 CONFIG_USB_DWC2=y
 CONFIG_USB_CHIPIDEA=y
-- 
2.7.4
