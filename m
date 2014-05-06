From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 6 May 2014 11:07:58 +1000
Subject: linux-next: manual merge of the mvebu tree with the arm-soc tree
Message-ID: <20140506110758.9ddcae1a0fa3b9548e37bc58@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the mvebu tree got a conflict in
arch/arm/mach-mvebu/Kconfig between commit 55400f3a1f89 ("ARM: mvebu:
clean-up unneeded kconfig selects") from the arm-soc tree and commit
8e6ac2033822 ("ARM: mvebu: enable the ARM SCU on Armada 375 and Armada
38x") from the mvebu tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-mvebu/Kconfig
index bfc5af18e483,d6b0a772a6dd..000000000000
--- a/arch/arm/mach-mvebu/Kconfig
+++ b/arch/arm/mach-mvebu/Kconfig
@@@ -3,8 -3,10 +3,9 @@@ config ARCH_MVEB
  	select ARCH_SUPPORTS_BIG_ENDIAN
  	select CLKSRC_MMIO
  	select GENERIC_IRQ_CHIP
 -	select IRQ_DOMAIN
  	select PINCTRL
  	select PLAT_ORION
+ 	select SOC_BUS
  	select MVEBU_MBUS
  	select ZONE_DMA if ARM_LPAE
  	select ARCH_REQUIRE_GPIOLIB
@@@ -36,6 -39,10 +37,9 @@@ config MACH_ARMADA_37
  	select ARM_ERRATA_753970
  	select ARM_GIC
  	select ARMADA_375_CLK
 -	select CPU_V7
+ 	select HAVE_ARM_SCU
+ 	select HAVE_ARM_TWD if SMP
+ 	select HAVE_SMP
  	select MACH_MVEBU_V7
  	select PINCTRL_ARMADA_375
  	help
@@@ -48,6 -55,10 +52,9 @@@ config MACH_ARMADA_38
  	select ARM_ERRATA_753970
  	select ARM_GIC
  	select ARMADA_38X_CLK
 -	select CPU_V7
+ 	select HAVE_ARM_SCU
+ 	select HAVE_ARM_TWD if SMP
+ 	select HAVE_SMP
  	select MACH_MVEBU_V7
  	select PINCTRL_ARMADA_38X
  	help
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140506/5db3ce9e/attachment-0001.sig>
