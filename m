From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Tue, 26 May 2015 12:58:37 +0200
Subject: [PATCH 1/2] ARM: multi_v7_defconfig: Replace CONFIG_USB_ISP1760_HCD
 by CONFIG_USB_ISP1760
Message-ID: <1432637918-8946-1-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Since commit 100832abf065bc18 ("usb: isp1760: Make HCD support
optional"), CONFIG_USB_ISP1760_HCD is automatically selected when
needed.  Enabling that option in the defconfig is now a no-op, and no
longer enables ISP1760 HCD support.

Re-enable the ISP1760 driver in the defconfig by enabling
USB_ISP1760_HOST_ROLE instead.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/multi_v7_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a6bbfeef3e36612a..e3fc9799972367c3 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -475,7 +475,7 @@ CONFIG_USB_EHCI_EXYNOS=y
 CONFIG_USB_EHCI_TEGRA=y
 CONFIG_USB_EHCI_HCD_STI=y
 CONFIG_USB_EHCI_HCD_PLATFORM=y
-CONFIG_USB_ISP1760_HCD=y
+CONFIG_USB_ISP1760=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_OHCI_HCD_STI=y
 CONFIG_USB_OHCI_HCD_PLATFORM=y
-- 
1.9.1
