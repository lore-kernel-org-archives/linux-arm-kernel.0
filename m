From: arnd@arndb.de (Arnd Bergmann)
Date: Fri,  5 Oct 2012 16:55:14 +0200
Subject: [PATCH 00/16] ARM: mostly harmless gcc warnings
Message-ID: <1349448930-23976-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In my attempt to weed out all warnings in ARM defconfigs, this
is the latest installment of patches. Ideally these could all
go through the respective subsystem maintainer trees, but
for any patches I don't hear anything back on, I will just
merge them through the arm-soc tree.

	Arnd

Arnd Bergmann (16):
  ARM: warnings in arch/arm/include/asm/uaccess.h
  ARM: binfmt_flat: unused variable 'persistent'
  SCSI: ARM: ncr5380/oak uses no interrupts
  SCSI: ARM: make fas216_dumpinfo function conditional
  vfs: bogus warnings in fs/namei.c
  mm/slob: use min_t() to compare ARCH_SLAB_MINALIGN
  cgroup: fix warning when building without any subsys
  ipvs: fix ip_vs_set_timeout debug messages
  USB: EHCI: mark ehci_orion_conf_mbus_windows __devinit
  clk: don't mark clkdev_add_table as init
  pcmcia: sharpsl: don't discard sharpsl_pcmcia_ops
  video: mark nuc900fb_map_video_memory as __devinit
  ARM: be really quiet when building with 'make -s'
  ARM: pxa: armcore: fix PCI PIO warnings
  spi/s3c64xx: use correct dma_transfer_direction type
  ARM: pass -marm to gcc by default for both C and assembler

 arch/arm/Makefile               |   13 +++++++------
 arch/arm/boot/Makefile          |   10 +++++-----
 arch/arm/common/it8152.c        |   12 +++++++++---
 arch/arm/include/asm/flat.h     |    2 +-
 arch/arm/include/asm/uaccess.h  |    4 ++--
 arch/arm/tools/Makefile         |    2 +-
 drivers/clk/clkdev.c            |    2 +-
 drivers/pcmcia/pxa2xx_sharpsl.c |    2 +-
 drivers/scsi/arm/fas216.c       |    2 +-
 drivers/scsi/arm/oak.c          |    1 +
 drivers/spi/spi-s3c64xx.c       |    2 +-
 drivers/usb/host/ehci-orion.c   |    2 +-
 drivers/video/nuc900fb.c        |    2 +-
 fs/namei.c                      |    6 +++---
 include/linux/cgroup.h          |    2 +-
 mm/slob.c                       |    6 +++---
 net/netfilter/ipvs/ip_vs_ctl.c  |   10 ++++++----
 17 files changed, 45 insertions(+), 35 deletions(-)

Cc: "James E.J. Bottomley" <JBottomley@parallels.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Ben Blum <bblum@andrew.cmu.edu>
Cc: Ben Dooks <ben-linux@fluff.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Bryan Wu <bryan.wu@canonical.com>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Lameter <cl@linux.com>
Cc: Dave Martin <dave.martin@linaro.org>
Cc: David S. Miller <davem@davemloft.net>
Cc: Dominik Brodowski <linux@dominikbrodowski.net>
Cc: Eric Miao <eric.y.miao@gmail.com>
Cc: Florian Tobias Schandinat <FlorianSchandinat@gmx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Greg Ungerer <gerg@uclinux.org>
Cc: Haojian Zhuang <haojian.zhuang@gmail.com>
Cc: Igor Grinberg <grinberg@compulab.co.il>
Cc: Jan Kara <jack@suse.cz>
Cc: Jochen Friedrich <jochen@scram.de>
Cc: Julian Anastasov <ja@ssi.bg>
Cc: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Kukjin Kim <kgene.kim@samsung.com>
Cc: Li Zefan <lizefan@huawei.com>
Cc: Michal Marek <mmarek@suse.cz>
Cc: Mike Rapoport <mike@compulab.co.il>
Cc: Mike Turquette <mturquette@linaro.org>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Pavel Machek <pavel@suse.cz>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: Russell King <rmk+kernel@arm.linux.org.uk>
Cc: Simon Horman <horms@verge.net.au>
Cc: Tejun Heo <tj@kernel.org>
Cc: Wan ZongShun <mcuos.com@gmail.com>
Cc: coreteam at netfilter.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: linux-fbdev at vger.kernel.org
Cc: linux-fsdevel at vger.kernel.org
Cc: linux-pcmcia at lists.infradead.org
Cc: linux-samsung-soc at vger.kernel.org
Cc: linux-scsi at vger.kernel.org
Cc: linux-usb at vger.kernel.org
Cc: netdev at vger.kernel.org
Cc: netfilter-devel at vger.kernel.org
Cc: netfilter at vger.kernel.org
Cc: spi-devel-general at lists.sourceforge.net


-- 
1.7.10
