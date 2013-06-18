From: tony@atomide.com (Tony Lindgren)
Date: Tue, 18 Jun 2013 11:07:27 -0700
Subject: [GIT PULL 7/7] omap mailbox move to drivers for v3.11 merge window
In-Reply-To: <pull-1371578847-800598>
Message-ID: <mailman.10.1371578952.1060.linux-arm-kernel@lists.infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 317ddd256b9c24b0d78fa8018f80f1e495481a10:

  Linux 3.10-rc5 (2013-06-08 17:41:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v3.11/mailbox-signed

for you to fetch changes up to d2e993289cc5f1780ce74188e3a8d2b404748397:

  Merge tag 'omap-mailbox-for-v3.11' of git://github.com/sumananna/mailbox into omap-for-v3.11/mailbox (2013-06-17 03:51:54 -0700)

----------------------------------------------------------------

Move OMAP Mailbox framework to drivers via Suman Anna <s-anna@ti.com>

The OMAP Mailbox driver framework is moved out of arch/arm folder
into drivers/mailbox folder, to re-enable building it and also serve
as a baseline for adapting to the new mailbox driver framework. The
changes mainly contain:
  - a minor bug fix and cleanup of mach-specific mailbox code
  - remove any header dependencies from plat-omap for multi-platform
    support
  - represent mailbox device data through platform data/hwmod attrs
  - move the omap mailbox code out of plat-omap/mach-omapX to
    drivers/mailbox folder

----------------------------------------------------------------
Suman Anna (6):
      omap: mailbox: check iomem resource before dereferencing it
      omap: mailbox: call request_irq after mbox queues are allocated
      omap: mailbox: correct the argument type for irq ops
      ARM: OMAP2+: mbox: remove dependencies with soc.h
      ARM: OMAP2+: add user and fifo info to mailbox platform data
      mailbox/omap: move the OMAP mailbox framework to drivers

Tony Lindgren (1):
      Merge tag 'omap-mailbox-for-v3.11' of git://github.com/sumananna/mailbox into omap-for-v3.11/mailbox

 arch/arm/configs/omap1_defconfig                   |   3 +-
 arch/arm/mach-omap1/Makefile                       |   4 -
 arch/arm/mach-omap2/Makefile                       |   3 -
 arch/arm/mach-omap2/devices.c                      |  13 +-
 arch/arm/mach-omap2/omap_hwmod_2420_data.c         |  14 ++
 arch/arm/mach-omap2/omap_hwmod_2430_data.c         |  13 +
 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c         |  13 +
 arch/arm/plat-omap/Kconfig                         |  16 --
 arch/arm/plat-omap/Makefile                        |   3 -
 drivers/mailbox/Kconfig                            |  34 +++
 drivers/mailbox/Makefile                           |   6 +
 .../mailbox.c => drivers/mailbox/mailbox-omap1.c   |  12 +-
 .../mailbox.c => drivers/mailbox/mailbox-omap2.c   | 276 ++++++++-------------
 .../mailbox.c => drivers/mailbox/omap-mailbox.c    |  54 +++-
 .../plat/mailbox.h => drivers/mailbox/omap-mbox.h  |  70 ++----
 drivers/remoteproc/Kconfig                         |   3 +-
 drivers/remoteproc/omap_remoteproc.c               |   2 +-
 drivers/staging/tidspbridge/Kconfig                |   3 +-
 .../tidspbridge/include/dspbridge/host_os.h        |   2 +-
 include/linux/omap-mailbox.h                       |  29 +++
 include/linux/platform_data/mailbox-omap.h         |  58 +++++
 21 files changed, 355 insertions(+), 276 deletions(-)
 rename arch/arm/mach-omap1/mailbox.c => drivers/mailbox/mailbox-omap1.c (94%)
 rename arch/arm/mach-omap2/mailbox.c => drivers/mailbox/mailbox-omap2.c (59%)
 rename arch/arm/plat-omap/mailbox.c => drivers/mailbox/omap-mailbox.c (92%)
 rename arch/arm/plat-omap/include/plat/mailbox.h => drivers/mailbox/omap-mbox.h (54%)
 create mode 100644 include/linux/omap-mailbox.h
 create mode 100644 include/linux/platform_data/mailbox-omap.h
