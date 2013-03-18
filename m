From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Mon, 18 Mar 2013 15:04:15 +1100
Subject: linux-next: manual merge of the bcm2835 tree with the arm-soc tree
Message-ID: <20130318150415.7a9db62e8cfe03623a411ae9@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

Today's linux-next merge of the bcm2835 tree got a conflict in
arch/arm/Kconfig between commit 15bc1fe67f66 ("ARM: cns3xxx: enable
multiplatform support") from the arm-soc tree and commit f1ac922dec7e
("ARM: bcm2835: convert to multi-platform") from the bcm2835 tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/Kconfig
index c63daef,0d3daa6..0000000
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@@ -362,26 -362,17 +362,6 @@@ config ARCH_AT9
  	  This enables support for systems based on Atmel
  	  AT91RM9200 and AT91SAM9* processors.
  
- config ARCH_BCM2835
- 	bool "Broadcom BCM2835 family"
- 	select ARCH_REQUIRE_GPIOLIB
- 	select ARM_AMBA
- 	select ARM_ERRATA_411920
- 	select ARM_TIMER_SP804
- 	select CLKDEV_LOOKUP
- 	select CLKSRC_OF
- 	select COMMON_CLK
- 	select CPU_V6
- 	select GENERIC_CLOCKEVENTS
- 	select MULTI_IRQ_HANDLER
- 	select PINCTRL
- 	select PINCTRL_BCM2835
- 	select SPARSE_IRQ
- 	select USE_OF
- 	help
- 	  This enables support for the Broadcom BCM2835 SoC. This SoC is
- 	  use in the Raspberry Pi, and Roku 2 devices.
- 
 -config ARCH_CNS3XXX
 -	bool "Cavium Networks CNS3XXX family"
 -	select ARM_GIC
 -	select CPU_V6K
 -	select GENERIC_CLOCKEVENTS
 -	select MIGHT_HAVE_CACHE_L2X0
 -	select MIGHT_HAVE_PCI
 -	select PCI_DOMAINS if PCI
 -	help
 -	  Support for Cavium Networks CNS3XXX platform.
 -
  config ARCH_CLPS711X
  	bool "Cirrus Logic CLPS711x/EP721x/EP731x-based"
  	select ARCH_REQUIRE_GPIOLIB
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130318/a0786402/attachment.sig>
