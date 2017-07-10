From: geert+renesas@glider.be (Geert Uytterhoeven)
Date: Mon, 10 Jul 2017 15:28:15 +0200
Subject: [PATCH 2/9] ARM: shmobile: defconfig: Replace USB_XHCI_RCAR by
 USB_XHCI_PLATFORM
In-Reply-To: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
References: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
Message-ID: <1499693302-25120-3-git-send-email-geert+renesas@glider.be>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

USB_XHCI_RCAR is no longer enabled, as it now has a dependency on
USB_XHCI_PLATFORM, instead of selecting USB_XHCI_PLATFORM.
As the latter selects the former if ARCH_RENESAS, fix this by replacing
USB_XHCI_RCAR by USB_XHCI_PLATFORM in shmobile_defconfig.

Fixes: f879fc32aa0c96fb ("usb: host: xhci-rcar: Avoid long wait in xhci_reset()")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 arch/arm/configs/shmobile_defconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/configs/shmobile_defconfig b/arch/arm/configs/shmobile_defconfig
index 04cd18424016eba5..bfbeae3f6a884987 100644
--- a/arch/arm/configs/shmobile_defconfig
+++ b/arch/arm/configs/shmobile_defconfig
@@ -175,7 +175,7 @@ CONFIG_SND_SOC_AK4642=y
 CONFIG_SND_SOC_WM8978=y
 CONFIG_USB=y
 CONFIG_USB_XHCI_HCD=y
-CONFIG_USB_XHCI_RCAR=y
+CONFIG_USB_XHCI_PLATFORM=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_R8A66597_HCD=y
-- 
2.7.4
