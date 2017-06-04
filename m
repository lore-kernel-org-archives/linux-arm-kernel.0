From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 5 Jun 2017 09:48:03 +1000
Subject: linux-next: manual merge of the at91 tree with the arm-soc tree
Message-ID: <20170605094803.466a6132@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nicolas,

Today's linux-next merge of the at91 tree got a conflict in:

  arch/arm/mach-at91/Kconfig

between commit:

  cc7a938f5f30 ("ARM: at91: select CONFIG_ARM_CPU_SUSPEND")

from the arm-soc tree and commit:

  81c0bb0b6ad1 ("ARM: at91: Add armv7m support")

from the at91 tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

-- 
Cheers,
Stephen Rothwell

diff --cc arch/arm/mach-at91/Kconfig
index cbd959b73654,7497a28a79d1..000000000000
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@@ -1,7 -1,6 +1,7 @@@
  menuconfig ARCH_AT91
  	bool "Atmel SoCs"
- 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7
+ 	depends on ARCH_MULTI_V4T || ARCH_MULTI_V5 || ARCH_MULTI_V7 || ARM_SINGLE_ARMV7M
 +	select ARM_CPU_SUSPEND if PM
  	select COMMON_CLK_AT91
  	select GPIOLIB
  	select PINCTRL
