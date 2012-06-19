From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 19 Jun 2012 08:53:00 +0200
Subject: [GIT PULL] Integrator common clock
Message-ID: <CACRpkdYj46c1dpBhassGn2DWOpcmHHUQcUGb6VZ-bVL8bc2PJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi ARM SoC people,

would you consider pulling in the support form common clk in the Integrator,
unless Mike shouts at me? I think I have adressed all review comments.

There will at some point be some trivial merge conflicts in drivers/clk/Makefile
I think, but you're used to that I think...

Yours,
Linus Walleij

The following changes since commit f8f5701bdaf9134b1f90e5044a82c66324d2073f:

  Linux 3.5-rc1 (2012-06-02 18:29:26 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-integrator.git
integrator-clk

for you to fetch changes up to aa3f7190e46514002ddf5b6054d7dc9f6f9f9cb7:

  ARM: integrator: convert to common clock (2012-06-15 09:00:43 +0200)

----------------------------------------------------------------
Linus Walleij (3):
      ARM: integrator: put symbolic bus names on devices
      clk: add versatile ICST307 driver
      ARM: integrator: convert to common clock

 arch/arm/Kconfig                               |    8 +-
 arch/arm/mach-integrator/core.c                |   55 ++----------
 arch/arm/mach-integrator/include/mach/clkdev.h |   26 ------
 arch/arm/mach-integrator/integrator_ap.c       |    8 +-
 arch/arm/mach-integrator/integrator_cp.c       |   69 ++-------------
 arch/arm/plat-versatile/Kconfig                |    3 +
 arch/arm/plat-versatile/Makefile               |    2 +-
 drivers/clk/Kconfig                            |    2 +
 drivers/clk/Makefile                           |    1 +
 drivers/clk/versatile/Kconfig                  |    8 ++
 drivers/clk/versatile/Makefile                 |    3 +
 drivers/clk/versatile/clk-icst.c               |  100 +++++++++++++++++++++
 drivers/clk/versatile/clk-icst.h               |   10 +++
 drivers/clk/versatile/clk-integrator.c         |  111 ++++++++++++++++++++++++
 include/linux/platform_data/clk-integrator.h   |    1 +
 15 files changed, 263 insertions(+), 144 deletions(-)
 delete mode 100644 arch/arm/mach-integrator/include/mach/clkdev.h
 create mode 100644 drivers/clk/versatile/Kconfig
 create mode 100644 drivers/clk/versatile/Makefile
 create mode 100644 drivers/clk/versatile/clk-icst.c
 create mode 100644 drivers/clk/versatile/clk-icst.h
 create mode 100644 drivers/clk/versatile/clk-integrator.c
 create mode 100644 include/linux/platform_data/clk-integrator.h
