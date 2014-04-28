From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 28 Apr 2014 12:01:26 -0700
Subject: [PATCH 00/15] pinctrl: sunxi: Rework and cleanups
Message-ID: <1398711701-11309-1-git-send-email-maxime.ripard@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patchset does some rework and clean up on the Allwinner pinctrl
driver.

The most noticable thing is that we split the huge header containing
the pins into smaller independant drivers.

That brings two important things: now, you don't have the structures
redefined as much time as there's an include of the header, which is
not that great, and you can select each drivers independently,
reducing the global size if you're interested only in a single SoC.

Maxime

Maxime Ripard (15):
  pinctrl: sunxi: Add const qualifier to the pin descriptor
  pinctrl: sunxi: Drop unused structure members
  pinctrl: sunxi: Move the Allwinner pinctrl driver to its own directory
  pinctrl: sunxi: Replace hardcoded pin defines by a macro
  pinctrl: sunxi: Switch to devm_ioremap_resource
  pinctrl: sunxi: Libraryse the driver
  pinctrl: sunxi: Move Allwinner A10 pinctrl driver to a driver of its
    own
  pinctrl: sunxi: Move Allwinner A10s pinctrl driver to a driver of its
    own
  pinctrl: sunxi: Move Allwinner A13 pinctrl driver to a driver of its
    own
  pinctrl: sunxi: Move Allwinner A31 pinctrl driver to a driver of its
    own
  pinctrl: sunxi: Move Allwinner A31 special pins driver to a driver of
    its own
  pinctrl: sunxi: Move Allwinner A20 pinctrl driver to a driver of its
    own
  pinctrl: sunxi: Introduce per-driver Kconfig options
  pinctrl: sunxi: Move the reset handling functions out of the core
  ARM: sunxi: Update pinctrl Kconfig options

 arch/arm/mach-sunxi/Kconfig                 |    7 +-
 drivers/pinctrl/Kconfig                     |    6 +-
 drivers/pinctrl/Makefile                    |    2 +-
 drivers/pinctrl/pinctrl-sunxi-pins.h        | 3937 ---------------------------
 drivers/pinctrl/pinctrl-sunxi.c             |  953 -------
 drivers/pinctrl/pinctrl-sunxi.h             |  617 -----
 drivers/pinctrl/sunxi/Kconfig               |   32 +
 drivers/pinctrl/sunxi/Makefile              |   10 +
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c   | 1039 +++++++
 drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c  |  690 +++++
 drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c   |  411 +++
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c |  141 +
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c   |  884 ++++++
 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c   | 1065 ++++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.c       |  913 +++++++
 drivers/pinctrl/sunxi/pinctrl-sunxi.h       |  258 ++
 16 files changed, 5451 insertions(+), 5514 deletions(-)
 delete mode 100644 drivers/pinctrl/pinctrl-sunxi-pins.h
 delete mode 100644 drivers/pinctrl/pinctrl-sunxi.c
 delete mode 100644 drivers/pinctrl/pinctrl-sunxi.h
 create mode 100644 drivers/pinctrl/sunxi/Kconfig
 create mode 100644 drivers/pinctrl/sunxi/Makefile
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sunxi.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sunxi.h

-- 
1.9.1
