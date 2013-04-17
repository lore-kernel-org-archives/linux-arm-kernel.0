From: ezequiel.garcia@free-electrons.com (Ezequiel Garcia)
Date: Wed, 17 Apr 2013 16:51:34 -0300
Subject: [PATCH] ARM: mvebu: Add support for USB storage class in
 mvebu_defconfig
Message-ID: <1366228294-24437-1-git-send-email-ezequiel.garcia@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some boards can have built-in USB storage class controllers so
it's better to have this option included by default.

Currently this option is needed to support built-in USB MMC controller
found in Globalscale Mirabox board.

Signed-off-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
---
This is not important and can be delayed for v3.11 if it's already
too late for v3.10. The change is harmless in any case.

 arch/arm/configs/mvebu_defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/configs/mvebu_defconfig b/arch/arm/configs/mvebu_defconfig
index f3e8ae0..0837829 100644
--- a/arch/arm/configs/mvebu_defconfig
+++ b/arch/arm/configs/mvebu_defconfig
@@ -60,6 +60,7 @@ CONFIG_USB_SUPPORT=y
 CONFIG_USB=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_STORAGE=y
 CONFIG_MMC=y
 CONFIG_MMC_MVSDIO=y
 CONFIG_NEW_LEDS=y
-- 
1.8.1.5
