From: mporter@linaro.org (Matt Porter)
Date: Wed, 5 Mar 2014 23:48:16 -0500
Subject: [GIT PULL] ARM: mach-bcm: bcm281xx clock driver
Message-ID: <20140306044816.GA26681@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 6d0abeca3242a88cab8232e4acd7e2bf088f3bc2:

  Linux 3.14-rc3 (2014-02-16 13:30:25 -0800)

are available in the git repository at:

  git://github.com/broadcom/mach-bcm tags/armsoc/for-3.15/drivers

for you to fetch changes up to 1a5823c9209f0435347fcc079cf9b0dc01882db0:

  clk: bcm281xx: don't disable unused peripheral clocks (2014-02-24 13:50:36 -0500)

----------------------------------------------------------------
ARM: mach-bcm: bcm281xx clock driver

This pull request contains the Broadcom bcm281xx
clock driver series. This series is being merged
through the arm-soc tree because there is an
ordering dependency where the driver *must* be
merged before the related dts changes. This is
a result of the bcm281xx dts already containing
dummy fixed clock nodes that must be updated.

----------------------------------------------------------------
Alex Elder (2):
      clk: bcm281xx: add initial clock framework support
      clk: bcm281xx: don't disable unused peripheral clocks

 drivers/clk/Kconfig                  |    1 +
 drivers/clk/Makefile                 |    1 +
 drivers/clk/bcm/Kconfig              |    9 +
 drivers/clk/bcm/Makefile             |    3 +
 drivers/clk/bcm/clk-bcm281xx.c       |  416 ++++++++++++++
 drivers/clk/bcm/clk-kona-setup.c     |  769 +++++++++++++++++++++++++
 drivers/clk/bcm/clk-kona.c           | 1033 ++++++++++++++++++++++++++++++++++
 drivers/clk/bcm/clk-kona.h           |  410 ++++++++++++++
 include/dt-bindings/clock/bcm281xx.h |   65 +++
 9 files changed, 2707 insertions(+)
 create mode 100644 drivers/clk/bcm/Kconfig
 create mode 100644 drivers/clk/bcm/Makefile
 create mode 100644 drivers/clk/bcm/clk-bcm281xx.c
 create mode 100644 drivers/clk/bcm/clk-kona-setup.c
 create mode 100644 drivers/clk/bcm/clk-kona.c
 create mode 100644 drivers/clk/bcm/clk-kona.h
 create mode 100644 include/dt-bindings/clock/bcm281xx.h
