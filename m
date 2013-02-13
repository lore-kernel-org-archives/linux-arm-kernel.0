From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Wed, 13 Feb 2013 18:18:29 +1100
Subject: linux-next: manual merge of the arm-soc tree with the metag tree
Message-ID: <20130213181829.d8b9244c04b2eeb0e09ee5df@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Today's linux-next merge of the arm-soc tree got a conflict in
drivers/irqchip/Makefile between commit 270de53f851b ("metag: Internal
and external irqchips") from the metag tree and commit a900e5d99718
("ARM: exynos: move exynos4210-combiner to drivers/irqchip") from the
arm-soc tree.

I fixed it up (see below) and can carry the fix as necessary (no action
is required).

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au

diff --cc drivers/irqchip/Makefile
index ff02f6b,e65fbf2..0000000
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@@ -1,6 -1,9 +1,11 @@@
+ obj-$(CONFIG_IRQCHIP)			+= irqchip.o
+ 
  obj-$(CONFIG_ARCH_BCM2835)		+= irq-bcm2835.o
 +obj-$(CONFIG_METAG)			+= irq-metag-ext.o
 +obj-$(CONFIG_METAG_PERFCOUNTER_IRQS)	+= irq-metag.o
+ obj-$(CONFIG_ARCH_EXYNOS)		+= exynos-combiner.o
  obj-$(CONFIG_ARCH_SUNXI)		+= irq-sunxi.o
- obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
  obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
+ obj-$(CONFIG_ARM_GIC)			+= irq-gic.o
+ obj-$(CONFIG_ARM_VIC)			+= irq-vic.o
+ obj-$(CONFIG_VERSATILE_FPGA_IRQ)	+= irq-versatile-fpga.o
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130213/89b8886a/attachment-0001.sig>
