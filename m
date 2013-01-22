From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 22 Jan 2013 14:59:58 +0100
Subject: [GIT PULL] U300-related COH901318 cleanup
Message-ID: <CACRpkdZtWwHwvfNrSjZiY0Dn7qnk34R9ZSpLfH_VRhGzVEWpKQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC guys,

This pushes the platform data for the COH901318 DMA controller down
into the driver so it is self-contained as a cleanup for the U300 machine.

Since roughly 50% of this patch affects arch/arm/mach* and we may want
to build additional cleanups on top, we need to take this into the ARM
SoC tree.

All patches are ACKed by the DMA subsystem maintainer.

Please pull it into ARM SoC!

Yours,
Linus Walleij

The following changes since commit d1c3ed669a2d452cacfb48c2d171a1f364dae2ed:

  Linux 3.8-rc2 (2013-01-02 18:13:21 -0800)

are available in the git repository at:

  http://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-stericsson.git
tags/coh901318-for-arm-soc

for you to fetch changes up to 73b31eaee7f02946dbb0bfabbee72ab6f0117bfb:

  dma: coh901318: cut down on platform data abstraction (2013-01-07
17:36:41 +0100)

----------------------------------------------------------------
This pushes the platform data for the U300 COH901318
DMA controller down into the driver and cleans up in
the <mach/*> namespace for the U300 platform.

----------------------------------------------------------------
Linus Walleij (8):
      dma: coh901318: create a proper platform data file
      dma: coh901318: push platform data into driver
      dma: coh901318: remove hardcoded target addresses
      dma: coh901318: skip hard-coded addresses
      dma: coh901318: push header down into the DMA subsystem
      dma: coh901318: push definitions into driver
      dma: coh901318: merge header files
      dma: coh901318: cut down on platform data abstraction

 arch/arm/mach-u300/core.c                    | 1087 +--------------------
 arch/arm/mach-u300/dma_channels.h            |   60 --
 arch/arm/mach-u300/include/mach/coh901318.h  |  267 ------
 arch/arm/mach-u300/spi.c                     |    3 +-
 drivers/dma/coh901318.c                      | 1302 +++++++++++++++++++++++++-
 drivers/dma/{coh901318_lli.h => coh901318.h} |   35 +-
 drivers/dma/coh901318_lli.c                  |    4 +-
 include/linux/platform_data/dma-coh901318.h  |   72 ++
 8 files changed, 1354 insertions(+), 1476 deletions(-)
 delete mode 100644 arch/arm/mach-u300/dma_channels.h
 delete mode 100644 arch/arm/mach-u300/include/mach/coh901318.h
 rename drivers/dma/{coh901318_lli.h => coh901318.h} (81%)
 create mode 100644 include/linux/platform_data/dma-coh901318.h
