From: khilman@ti.com (Kevin Hilman)
Date: Tue, 15 Mar 2011 08:35:25 -0700
Subject: [GIT PULL] final davinci updates for 2.6.39
Message-ID: <87k4g0jt1e.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

A final pull request for davinci for 2.6.39 (based on the previous one.)

This is a series that Sekhar Nori (davinci co-maintaier) has been
tracking and that I had mistakenly not added to my previous pull request.

Thanks,

Kevin

The following changes since commit 9a9fb12a4832bdf22751e21df298ef3559643b43:

  davinci: macro rename DA8XX_LPSC0_DMAX to DA8XX_LPSC0_PRUSS. (2011-03-11 10:48:29 -0800)

are available in the git repository at:
  ssh://master.kernel.org/pub/scm/linux/kernel/git/khilman/linux-davinci.git davinci-next-2

Cyril Chemparathy (5):
      mfd: add driver for sequencer serial port
      spi: add ti-ssp spi master driver
      davinci: add tnetv107x ssp platform device
      davinci: add ssp config for tnetv107x evm board
      davinci: add spi devices on tnetv107x evm

Sergei Shtylyov (1):
      davinci: DM644x EVM: register MUSB device earlier

 arch/arm/mach-davinci/board-dm644x-evm.c       |    8 +-
 arch/arm/mach-davinci/board-tnetv107x-evm.c    |   57 +++
 arch/arm/mach-davinci/devices-tnetv107x.c      |   25 ++
 arch/arm/mach-davinci/include/mach/tnetv107x.h |    2 +
 arch/arm/mach-davinci/tnetv107x.c              |    2 +-
 drivers/mfd/Kconfig                            |   11 +
 drivers/mfd/Makefile                           |    1 +
 drivers/mfd/ti-ssp.c                           |  476 ++++++++++++++++++++++++
 drivers/spi/Kconfig                            |   10 +
 drivers/spi/Makefile                           |    1 +
 drivers/spi/ti-ssp-spi.c                       |  402 ++++++++++++++++++++
 include/linux/mfd/ti_ssp.h                     |   93 +++++
 12 files changed, 1082 insertions(+), 6 deletions(-)
 create mode 100644 drivers/mfd/ti-ssp.c
 create mode 100644 drivers/spi/ti-ssp-spi.c
 create mode 100644 include/linux/mfd/ti_ssp.h
