From: zajec5@gmail.com (=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?=)
Date: Sun, 21 Sep 2014 16:07:11 +0200
Subject: [PATCH V2] ARM: BCM5301X: select GPIOLIB as optional
In-Reply-To: <1411231282-7180-1-git-send-email-zajec5@gmail.com>
References: <1411231282-7180-1-git-send-email-zajec5@gmail.com>
Message-ID: <1411308431-20835-1-git-send-email-zajec5@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

All routers (or 99% of them) based on BCM5301X use GPIOs to control LEDs
and buttons.

Signed-off-by: Rafa? Mi?ecki <zajec5@gmail.com>
---
V2: Don't select GPIOLIB. We may still think about making it default at
    some point, but we dont' really require it to boot successfully.
---
 arch/arm/mach-bcm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-bcm/Kconfig b/arch/arm/mach-bcm/Kconfig
index fc93800..cf230dc3 100644
--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -80,6 +80,7 @@ config ARCH_BCM2835
 
 config ARCH_BCM_5301X
 	bool "Broadcom BCM470X / BCM5301X ARM SoC" if ARCH_MULTI_V7
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select ARM_GIC
 	select CACHE_L2X0
 	select HAVE_ARM_SCU if SMP
-- 
1.8.4.5
