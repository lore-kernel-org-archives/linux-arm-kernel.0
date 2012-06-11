From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 11 Jun 2012 18:15:39 +0200
Subject: [GIT PULL] Nomadik updates
Message-ID: <CACRpkdZtT72EoZTZzu2Ww7Z0CwzdV6EXp_UT+aMeKknSFzKt7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC maintainers,

could you please pull these Nomadik updates to the ARM SoC tree for
testing in -next. All patches have been reviewed and ACKed. This
alters Nomadik so we:
- Get rid of statically declared devices
- Support PL031 RTC
- Support MMC/SD card
- Convert to use common/generic clock
- Register the full set of I2C devices on the board
- Bump IRQs by one avoiding to use IRQ 0 which is now NO_IRQ

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-nomadik.git
nomadik-for-arm-soc

Linus Walleij (8):
      ARM: nomadik: register GPIOs dynamically
      ARM: nomadik: register AMBA devices dynamically
      ARM: nomadik: register PL031 RTC
      ARM: nomadik: convert to generic clock
      ARM: nomadik: register all three I2C busses
      ARM: nomadik: register the I2C devices
      ARM: nomadik: register the MMC/SD device
      ARM: nomadik: bump all IRQ numbers by one

 arch/arm/Kconfig                          |    2 +-
 arch/arm/mach-nomadik/Makefile            |    2 -
 arch/arm/mach-nomadik/board-nhk8815.c     |   67 +++++++++++++---
 arch/arm/mach-nomadik/clock.c             |   75 -----------------
 arch/arm/mach-nomadik/clock.h             |   15 ----
 arch/arm/mach-nomadik/cpu-8815.c          |  126 ++++++++++++-----------------
 arch/arm/mach-nomadik/i2c-8815nhk.c       |   38 +++++++--
 arch/arm/mach-nomadik/include/mach/irqs.h |   85 ++++++++++----------
 drivers/clk/Makefile                      |    1 +
 drivers/clk/clk-nomadik.c                 |   47 +++++++++++
 include/linux/platform_data/clk-nomadik.h |    2 +
 11 files changed, 230 insertions(+), 230 deletions(-)
 delete mode 100644 arch/arm/mach-nomadik/clock.c
 delete mode 100644 arch/arm/mach-nomadik/clock.h
 create mode 100644 drivers/clk/clk-nomadik.c
 create mode 100644 include/linux/platform_data/clk-nomadik.h
