From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Mar 2014 17:08:59 +0100
Subject: [PATCH 26/62] ARM: mvebu: don't select CONFIG_NEON
In-Reply-To: <532A0D17.9060105@free-electrons.com>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <20140319193740.GT15608@titan.lakedaemon.net>
 <532A0D17.9060105@free-electrons.com>
Message-ID: <201403211708.59462.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 March 2014, Gregory CLEMENT wrote:
> On 19/03/2014 20:37, Jason Cooper wrote:
> > On Wed, Mar 19, 2014 at 08:29:23PM +0100, Arnd Bergmann wrote:
> >> CONFIG_NEON is meant to be user-selectable. Turning it on
> >> unconditionally means we can't build a smaller kernel when
> >> we don't need it, and causes build errors if CONFIG_VFP
> >> is not also enabled.
> >>
> >> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >> Cc: Jason Cooper <jason@lakedaemon.net>
> >> Cc: Andrew Lunn <andrew@lunn.ch>
> >> Cc: Gregory Clement <gregory.clement@free-electrons.com>
> >> Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> >> ---
> >>  arch/arm/mach-mvebu/Kconfig | 2 --
> >>  1 file changed, 2 deletions(-)
> > 
> > Acked-by: Jason Cooper <jason@lakedaemon.net>
> 
> 
> Acked-by: Gregory CLEMENT <gregory.clement@free-electrons.com>

Thanks! Here is my new version.

	Arnd

>From 59532706506c0b3bf9f46499e7ba6c0f169e3802 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 24 Feb 2014 21:56:19 +0100
Subject: [PATCH] ARM: mvebu: don't select CONFIG_NEON

CONFIG_NEON is meant to be user-selectable. Turning it on
unconditionally means we can't build a smaller kernel when
we don't need it, and causes build errors if CONFIG_VFP
is not also enabled.

To still have neon enabled however, we need to turn it on
now in multi_v7_defconfig and mvebu_v7_defconfig.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Acked-by: Gregory Clement <gregory.clement@free-electrons.com>
Cc: Andrew Lunn <andrew@lunn.ch>
Cc: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index 9ee12b5..cd16989 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -63,6 +63,7 @@ CONFIG_ARCH_VEXPRESS_CA9X4=y
 CONFIG_ARCH_VIRT=y
 CONFIG_ARCH_WM8850=y
 CONFIG_ARCH_ZYNQ=y
+CONFIG_NEON=y
 CONFIG_TRUSTED_FOUNDATIONS=y
 CONFIG_PCI=y
 CONFIG_PCI_MSI=y
diff --git a/arch/arm/configs/mvebu_v7_defconfig b/arch/arm/configs/mvebu_v7_defconfig
index 62b6a37..a34713d 100644
--- a/arch/arm/configs/mvebu_v7_defconfig
+++ b/arch/arm/configs/mvebu_v7_defconfig
@@ -13,6 +13,7 @@ CONFIG_MACH_ARMADA_370=y
 CONFIG_MACH_ARMADA_375=y
 CONFIG_MACH_ARMADA_38X=y
 CONFIG_MACH_ARMADA_XP=y
+CONFIG_NEON=y
 # CONFIG_CACHE_L2X0 is not set
 # CONFIG_SWP_EMULATE is not set
 CONFIG_PCI=y
diff --git a/arch/arm/mach-mvebu/Kconfig b/arch/arm/mach-mvebu/Kconfig
index 485513cb..b24a082 100644
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@ -39,7 +39,6 @@ config MACH_ARMADA_375
 	select ARMADA_375_CLK
 	select CPU_V7
 	select MACH_MVEBU_V7
-	select NEON
 	select PINCTRL_ARMADA_375
 	help
 	  Say 'Y' here if you want your kernel to support boards based
@@ -53,7 +52,6 @@ config MACH_ARMADA_38X
 	select ARMADA_38X_CLK
 	select CPU_V7
 	select MACH_MVEBU_V7
-	select NEON
 	select PINCTRL_ARMADA_38X
 	help
 	  Say 'Y' here if you want your kernel to support boards based
