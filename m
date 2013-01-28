From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 28 Jan 2013 21:58:15 +0000
Subject: [PATCH v2 0/5] dmaengine: convert dw_dmac/spear13xx to generic binding
In-Reply-To: <1359395857-1235-1-git-send-email-arnd@arndb.de>
References: <1359395857-1235-1-git-send-email-arnd@arndb.de>
Message-ID: <1359410300-26113-1-git-send-email-arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi everyone,

I'm rather embarrassed to have sent yet another patch series
to the wrong mailing list address, this now goes to the
correct linux-arm-kernel list, so please comment here,
not on the first version. I have also made some smaller
changes and updated the DT bindings where I extended
the drivers. I also uploaded the git branch to the
spear/dma branch of
git://git.kernel.org/pub/scm/linux/kernel/git/arm/arm-soc.git

This is my attempt to convert the spear platform and the dw_dmac to
the generic device tree binding for DMA, so that we don't get
a release with the broken version. I'm pretty sure that this
has bugs, but it's as good as I could do without access to
hardware or specs.

Please review and comment,

	Arnd

Arnd Bergmann (5):
  dmaengine: dw_dmac: move to generic DMA binding
  spi: pl022: use generic DMA slave configuration if possible
  serial: pl011: use generic DMA slave configuration if possible
  ata: arasan: remove the need for platform_data
  ARM: SPEAr13xx: Pass generic DW DMAC platform data from DT

 .../devicetree/bindings/ata/pata-arasan.txt        |  22 ++++
 Documentation/devicetree/bindings/dma/snps-dma.txt |  70 +++++------
 arch/arm/boot/dts/spear1340.dtsi                   |   2 +
 arch/arm/boot/dts/spear13xx.dtsi                   |  25 +++-
 arch/arm/mach-spear/generic.h                      |   6 -
 arch/arm/mach-spear/include/mach/spear.h           |   2 -
 arch/arm/mach-spear/spear1310.c                    |  30 +----
 arch/arm/mach-spear/spear1340.c                    |  32 +----
 arch/arm/mach-spear/spear13xx-dma.h                | 128 --------------------
 arch/arm/mach-spear/spear13xx.c                    |  58 ---------
 drivers/ata/pata_arasan_cf.c                       |  31 +++--
 drivers/dma/dw_dmac.c                              | 130 ++++++++++-----------
 drivers/dma/dw_dmac_regs.h                         |   4 -
 drivers/spi/spi-pl022.c                            |  43 ++++++-
 drivers/tty/serial/amba-pl011.c                    |  62 ++++++----
 include/linux/dw_dmac.h                            |   5 -
 include/linux/pata_arasan_cf_data.h                |   2 -
 17 files changed, 243 insertions(+), 409 deletions(-)
 delete mode 100644 arch/arm/mach-spear/spear13xx-dma.h

-- 
1.8.0

Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jeff Garzik <jgarzik@redhat.com>
Cc: Jon Hunter <jon-hunter@ti.com>
Cc: Jiri Slaby <jslaby@suse.cz>
Cc: Linus Walleij <linus.walleij@linaro.org>
Cc: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Vinod Koul <vinod.koul@linux.intel.com>
Cc: Viresh Kumar <viresh.kumar@linaro.org>
Cc: devicetree-discuss at lists.ozlabs.org
Cc: linux-arm-kernel at lists.infradead.org
Cc: spi-devel-general at lists.sourceforge.net
