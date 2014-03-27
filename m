From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 27 Mar 2014 16:27:41 +0100
Subject: [PATCH] ARM: sunxi: Select HAVE_ARM_ARCH_TIMER
Message-ID: <1395934061-5340-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In order for the architected timers support to be enabled in the kernel, this
option has to be enabled. Otherwise, the architected timers driver won't be
compiled in, and we will not get to use them.

Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
---

Hi Arnd, Kevin, Olof,

It would be great if you could apply this patch directly on top of the current
arm-soc for-next.

Thanks!

 arch/arm/mach-sunxi/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-sunxi/Kconfig b/arch/arm/mach-sunxi/Kconfig
index b9d6cad8669b..931adeaf35d2 100644
--- a/arch/arm/mach-sunxi/Kconfig
+++ b/arch/arm/mach-sunxi/Kconfig
@@ -9,6 +9,7 @@ config ARCH_SUNXI
 	select COMMON_CLK
 	select GENERIC_CLOCKEVENTS
 	select GENERIC_IRQ_CHIP
+	select HAVE_ARM_ARCH_TIMER
 	select HAVE_SMP
 	select PINCTRL
 	select PINCTRL_SUNXI
-- 
1.9.0
