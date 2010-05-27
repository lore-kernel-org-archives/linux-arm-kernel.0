From: dan.j.williams@intel.com (Dan Williams)
Date: Thu, 27 May 2010 16:01:20 -0700
Subject: [GIT PULL] final dmaengine update for 2.6.35-rc1
Message-ID: <1275001280.21315.14.camel@dwillia2-linux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus, please pull from:

  git://git.kernel.org/pub/scm/linux/kernel/git/djbw/async_tx.git next

1/ A new dma driver from Jassi that was dependent on patches that went
in via the ARM tree.

2/ A platform enabling patch for the dma40 driver that went in with my
first pull request.  This was pending an acked-by from Russell.

Both have been shaken out in -next, the dma40 patch had some recent
janitorial fixups spotted by Russell.

Thanks,
Dan

Jassi Brar (1):
      DMA: PL330: Add dma api driver

Linus Walleij (1):
      DMAENGINE: DMA40 U8500 platform configuration

 arch/arm/mach-ux500/clock.c                    |    2 +-
 arch/arm/mach-ux500/cpu-db8500.c               |    4 +
 arch/arm/mach-ux500/devices-db8500.c           |  109 +++
 arch/arm/mach-ux500/include/mach/db8500-regs.h |   12 +
 arch/arm/mach-ux500/include/mach/devices.h     |    3 +
 arch/arm/mach-ux500/ste-dma40-db8500.h         |  154 +++++
 drivers/dma/Kconfig                            |    9 +
 drivers/dma/Makefile                           |    1 +
 drivers/dma/pl330.c                            |  866 ++++++++++++++++++++++++
 include/linux/amba/pl330.h                     |   45 ++
 10 files changed, 1204 insertions(+), 1 deletions(-)
 create mode 100644 arch/arm/mach-ux500/ste-dma40-db8500.h
 create mode 100644 drivers/dma/pl330.c
 create mode 100644 include/linux/amba/pl330.h

commit 7b8ddb06e54ad98edeb7951f317aee4d1feda9d6
Author: Linus Walleij <linus.walleij@stericsson.com>
Date:   Thu May 27 15:21:26 2010 -0700

    DMAENGINE: DMA40 U8500 platform configuration
    
    This completes the DMA40 support with the platform-specific
    configuration for U8500/DB8500.
    
    Signed-off-by: Linus Walleij <linus.walleij@stericsson.com>
    Acked-by: Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>
    Reviewed-by: Alessandro Rubini <rubini@unipv.it>
    Cc: STEricsson_nomadik_linux at list.st.com
    Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>
    [fixed up dma40_{tx|rx}_map declaration/initialization]
    Signed-off-by: Dan Williams <dan.j.williams@intel.com>

commit b3040e40675ec2c43542331cd30d4ee3dae797e8
Author: Jassi Brar <jassi.brar@samsung.com>
Date:   Sun May 23 20:28:19 2010 -0700

    DMA: PL330: Add dma api driver
    
    Add DMA Engine API driver for the PL330 DMAC.
    This driver is supposed to be reusable by various
    platforms that have one or more PL330 DMACs.
    Atm, DMA_SLAVE and DMA_MEMCPY capabilities have been
    implemented.
    
    Signed-off-by: Jassi Brar <jassi.brar@samsung.com>
    Reviewed-by: Linus Walleij <linus.walleij@stericsson.com>
    [dan.j.williams at intel.com: missing slab.h and ->device_control() fixups]
    Signed-off-by: Dan Williams <dan.j.williams@intel.com>
