From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Thu, 18 Feb 2016 03:06:08 +0100
Subject: [GIT PULL] at91: drivers for 4.6 #1
Message-ID: <20160218020608.GA31682@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

This is a rework of the PMC driver. It touches multiple subsystems so
the easiest path is through arm-soc.

Thanks,

The following changes since commit 92e963f50fc74041b5e9e744c330dca48e04f08d:

  Linux 4.5-rc1 (2016-01-24 13:06:47 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/at91-ab-4.6-drivers

for you to fetch changes up to 0002ca168f16e5b6ac67415a4e0198cc39af2b7f:

  clk: at91: remove useless includes (2016-02-17 17:53:04 +0100)

----------------------------------------------------------------
drivers update for 4.6:
 - Big PMC rework that touches clk, PM, usb

----------------------------------------------------------------
Alexandre Belloni (11):
      clk: at91: remove IRQ handling and use polling
      clk: at91: pmc: merge at91_pmc_init in atmel_pmc_probe
      clk: at91: pmc: move pmc structures to C file
      ARM: at91: pm: simply call at91_pm_init
      ARM: at91: pm: find and remap the pmc
      ARM: at91: pm: move idle functions to pm.c
      ARM: at91: remove useless includes and function prototypes
      usb: gadget: atmel: access the PMC using regmap
      clk: at91: pmc: drop at91_pmc_base
      clk: at91: pmc: remove useless capacities handling
      clk: at91: remove useless includes

Boris Brezillon (2):
      clk: at91: make use of syscon to share PMC registers in several drivers
      clk: at91: make use of syscon/regmap internally

 arch/arm/mach-at91/Kconfig              |   1 +
 arch/arm/mach-at91/at91rm9200.c         |   2 -
 arch/arm/mach-at91/at91sam9.c           |   2 -
 arch/arm/mach-at91/generic.h            |  13 +-
 arch/arm/mach-at91/pm.c                 |  70 +++++-
 arch/arm/mach-at91/sama5.c              |   2 +-
 drivers/clk/at91/clk-generated.c        |  95 ++++---
 drivers/clk/at91/clk-h32mx.c            |  40 +--
 drivers/clk/at91/clk-main.c             | 324 +++++++++++-------------
 drivers/clk/at91/clk-master.c           |  94 +++----
 drivers/clk/at91/clk-peripheral.c       | 137 +++++-----
 drivers/clk/at91/clk-pll.c              | 150 +++++------
 drivers/clk/at91/clk-plldiv.c           |  44 ++--
 drivers/clk/at91/clk-programmable.c     |  96 +++----
 drivers/clk/at91/clk-slow.c             |  35 +--
 drivers/clk/at91/clk-smd.c              |  56 +++--
 drivers/clk/at91/clk-system.c           |  96 +++----
 drivers/clk/at91/clk-usb.c              | 123 ++++-----
 drivers/clk/at91/clk-utmi.c             |  80 ++----
 drivers/clk/at91/pmc.c                  | 426 +-------------------------------
 drivers/clk/at91/pmc.h                  |  98 +-------
 drivers/usb/gadget/udc/atmel_usba_udc.c |  20 +-
 drivers/usb/gadget/udc/atmel_usba_udc.h |   2 +
 include/linux/clk/at91_pmc.h            |  12 -
 24 files changed, 724 insertions(+), 1294 deletions(-)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160218/e96f2dc7/attachment-0001.sig>
