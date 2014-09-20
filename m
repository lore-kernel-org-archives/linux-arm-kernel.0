From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sat, 20 Sep 2014 18:41:22 +0200
Subject: [PATCH] ARM: BCM5301X: select GPIOLIB as optional
Message-ID: <1411231282-7180-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All routers (or 99% of them) based on BCM5301X use GPIOs to control LEDs
and buttons.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
 arch/arm/mach-bcm/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index fc93800..d967c98 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -80,8 +80,10 @@ config ARCH_BCM2835
 
 config ARCH_BCM_5301X
 	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CACHE_L2X0
+	select GPIOLIB
 	select HAVE_ARM_SCU if SMP
 	select HAVE_ARM_TWD if SMP
 	select ARM_GLOBAL_TIMER
-- 
1.8.4.5
