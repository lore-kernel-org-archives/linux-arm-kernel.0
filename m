From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 7 Oct 2014 12:39:26 +1100
Subject: linux-next: manual merge of the kbuild tree with the arm-soc tree
Message-ID: <20141007123926.0e14810b@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Michal,

Today's linux-next merge of the kbuild tree got a conflict in
arch/arm/mach-at91/Makefile between commit 91a55d4f6900 ("ARM: at91:
introduce OLD_IRQ_AT91 Kconfig option") from the arm-soc tree and
commit ac84eb47cc19 ("kbuild: remove unnecessary variable
initializaions") from the kbuild tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/mach-at91/Makefile
index ac99d87ffefe,75033839fc08..000000000000
--- a/arch/arm/mach-at91/Makefile
+++ b/arch/arm/mach-at91/Makefile
@@@ -2,13 -2,12 +2,10 @@@
  # Makefile for the linux kernel.
  #
  
 -obj-y		:= irq.o gpio.o setup.o sysirq_mask.o
 +obj-y		:= gpio.o setup.o sysirq_mask.o
- obj-m		:=
- obj-n		:=
- obj-		:=
  
 +obj-$(CONFIG_OLD_IRQ_AT91)	+= irq.o
  obj-$(CONFIG_OLD_CLK_AT91)	+= clock.o
 -obj-$(CONFIG_AT91_SAM9_ALT_RESET) += at91sam9_alt_reset.o
 -obj-$(CONFIG_AT91_SAM9G45_RESET) += at91sam9g45_reset.o
 -obj-$(CONFIG_AT91_SAM9_TIME)	+= at91sam926x_time.o
  obj-$(CONFIG_SOC_AT91SAM9)	+= sam9_smc.o
  
  # CPU-specific support
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141007/92bcb303/attachment.sig>
