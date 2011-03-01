From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 1 Mar 2011 16:11:38 +0100
Subject: [PATCH] mach-ux500: activate USB in the U8500 defconfig
Message-ID: <1298992298-31854-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

Activate the new USB stuff so we atleast get some compile
coverage for this stuff.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 arch/arm/configs/u8500_defconfig |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/arch/arm/configs/u8500_defconfig b/arch/arm/configs/u8500_defconfig
index a5cce24..e1d6020 100644
--- a/arch/arm/configs/u8500_defconfig
+++ b/arch/arm/configs/u8500_defconfig
@@ -67,7 +67,11 @@ CONFIG_AB8500_CORE=y
 CONFIG_REGULATOR=y
 CONFIG_REGULATOR_AB8500=y
 # CONFIG_HID_SUPPORT is not set
-# CONFIG_USB_SUPPORT is not set
+CONFIG_USB_MUSB_HDRC=y
+CONFIG_USB_GADGET_MUSB_HDRC=y
+CONFIG_MUSB_PIO_ONLY=y
+CONFIG_USB_GADGET=y
+CONFIG_AB8500_USB=y
 CONFIG_MMC=y
 CONFIG_MMC_ARMMMCI=y
 CONFIG_NEW_LEDS=y
-- 
1.7.3.2
