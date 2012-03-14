From: b-cousson@ti.com (Cousson, Benoit)
Date: Wed, 14 Mar 2012 14:36:57 +0100
Subject: [GIT PULL] mfd: twl: Fix for irqdomain/next + SPARSE_IRQ + MMC card
 detect
Message-ID: <4F609EF9.7040602@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Samuel,

Here is a fix + cleanup + SPARSE_IRQ series for TWL4030 and TWL6030.

I added the patch from Peter as well.

Please note that this series does depend on the irqdomain/next series
from Grant.

It is based on your current for-next branch + Grant's series merged on top.

Regards,
Benoit


The following changes since commit 81d14f4516578ca71d7f97612cb2b9cd4db0e7dd:
  Benoit Cousson (1):
        Merge remote branch 'grant/irqdomain/next' into HEAD

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/bcousson/linux-omap-dt.git for_3.4/twl_irq_gpio_mmc_fix

Benoit Cousson (8):
      mfd: twl6030-irq: Return twl6030_mmc_card_detect IRQ for board setup
      ARM: OMAP2+: board-omap4-*: Do not use anymore TWL6030_IRQ_BASE in board files
      mfd: twl-core: Remove references already defined in header file
      mfd: twl-core: Move IRQ allocation into twl[4030|6030]-irq files
      mfd: twl4030-irq: Make SIH SPARSE_IRQ capable
      mfd: twl-*: Replace pr_ macros by the dev_ equivalent and do various cleanups
      gpio/twl: Allocate irq_desc dynamically for SPARSE_IRQ support
      gpio/twl: Add DT support to gpio-twl4030 driver

Felipe Balbi (3):
      mfd: twl-core: don't depend on pdata->irq_base/end
      mfd: twl-core: remove unneeded header
      mfd: twl4030-irq: micro-optimization on IRQ handler

Peter Ujfalusi (1):
      mfd: twl-core: Detach twl6040 from the pmic mfd driver

 .../devicetree/bindings/gpio/gpio-twl4030.txt      |   23 +++
 arch/arm/mach-omap2/board-4430sdp.c                |   13 +-
 arch/arm/mach-omap2/board-omap4panda.c             |   15 +-
 drivers/gpio/gpio-twl4030.c                        |  111 +++++++++------
 drivers/mfd/twl-core.c                             |  154 +++++++++-----------
 drivers/mfd/twl-core.h                             |    4 +-
 drivers/mfd/twl4030-irq.c                          |   83 ++++++-----
 drivers/mfd/twl6030-irq.c                          |   71 ++++++----
 include/linux/i2c/twl.h                            |    2 +-
 9 files changed, 267 insertions(+), 209 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/gpio/gpio-twl4030.txt
