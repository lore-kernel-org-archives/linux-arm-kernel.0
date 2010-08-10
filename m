From: xsecute@googlemail.com (xsecute at googlemail.com)
Date: Tue, 10 Aug 2010 21:42:12 +0200
Subject: [PATCH]: Fix arm kconfig
Message-ID: <AANLkTikR-JJ9CP0eU3Lq251LPr_JRScBAih-dJdrt5fx@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

i get an nerror if i try: make ARCH=arm CROSS_COMPILE=arm-eabi

Output:
scripts/kconfig/mconf arch/arm/Kconfig
arch/arm/Kconfig:1187: invalid option
make[1]: *** [menuconfig] Error 1
make: *** [menuconfig] Error 2
--------------------------------------------------------
The following patch fix that.
==========================

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 232f0c7..684c1a1 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -1184,8 +1184,8 @@ config LOCAL_TIMERS
                REALVIEW_EB_A9MP || MACH_REALVIEW_PBX || ARCH_OMAP4 || \
                ARCH_U8500 || ARCH_VEXPRESS_CA9X4 || ARCH_TEGRA)
        default y
-       select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS ||
ARCH_OMAP4 || \\
-               ARCH_U8500 || ARCH_TEGRA
+       select HAVE_ARM_TWD if (ARCH_REALVIEW || ARCH_VEXPRESS ||
ARCH_OMAP4 || \
+               ARCH_U8500 || ARCH_TEGRA)
        help
          Enable support for local timers on SMP platforms, rather then the
          legacy IPI broadcast method.  Local timers allows the system
