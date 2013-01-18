From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Fri, 18 Jan 2013 14:21:31 +1100
Subject: linux-next: manual merge of the samsung tree with the arm-soc tree
Message-ID: <20130118142131.831834d9f26d917e3409e69e@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

Today's linux-next merge of the samsung tree got a conflict in
arch/arm/common/Makefile between commit 81243e444c6e ("irqchip: Move ARM
GIC to drivers/irqchip") from the arm-soc tree and commit cbafeaaa418e
("ARM: Add interface for registering and calling firmware-specific
operations") from the samsung tree.

I fixed it up (as supplied - see below) and can carry the fix as
necessary (no action is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc arch/arm/common/Makefile
index dc8dd0d,55d4182..0000000
--- a/arch/arm/common/Makefile
+++ b/arch/arm/common/Makefile
@@@ -2,6 -2,10 +2,8 @@@
  # Makefile for the linux kernel.
  #
  
+ obj-y += firmware.o
+ 
 -obj-$(CONFIG_ARM_GIC)		+= gic.o
 -obj-$(CONFIG_ARM_VIC)		+= vic.o
  obj-$(CONFIG_ICST)		+= icst.o
  obj-$(CONFIG_SA1111)		+= sa1111.o
  obj-$(CONFIG_PCI_HOST_VIA82C505) += via82c505.o
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130118/752d10c6/attachment.sig>
