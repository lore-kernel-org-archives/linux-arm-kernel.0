From: david@lechnology.com (David Lechner)
Date: Fri, 21 Oct 2016 13:36:53 -0500
Subject: [PATCH 1/5] ARM: davinci: Compile MMC in kernel
In-Reply-To: <1477075018-20176-1-git-send-email-david@lechnology.com>
References: <1477075018-20176-1-git-send-email-david@lechnology.com>
Message-ID: <1477075018-20176-2-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This changes the davinci default configuration to compile the davinci
MMC driver into the kernel. This allows booting from an SD card without
requiring an initrd containing the kernel module.

Signed-off-by: David Lechner <david@lechnology.com>
---
 arch/arm/configs/davinci_all_defconfig | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/configs/davinci_all_defconfig b/arch/arm/configs/davinci_all_defconfig
index 58d04f1..a2f89a3 100644
--- a/arch/arm/configs/davinci_all_defconfig
+++ b/arch/arm/configs/davinci_all_defconfig
@@ -169,9 +169,9 @@ CONFIG_USB_MASS_STORAGE=m
 CONFIG_USB_G_SERIAL=m
 CONFIG_USB_G_PRINTER=m
 CONFIG_USB_CDC_COMPOSITE=m
-CONFIG_MMC=m
+CONFIG_MMC=y
 # CONFIG_MMC_BLOCK_BOUNCE is not set
-CONFIG_MMC_DAVINCI=m
+CONFIG_MMC_DAVINCI=y
 CONFIG_NEW_LEDS=y
 CONFIG_LEDS_CLASS=m
 CONFIG_LEDS_GPIO=m
-- 
2.7.4
