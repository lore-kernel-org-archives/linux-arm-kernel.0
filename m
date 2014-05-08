From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 8 May 2014 17:52:09 -0500
Subject: [GIT PULL] Allwinner Pinctrl changes for 3.16
Message-ID: <20140508225209.GA13610@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit fd67f884782a281eb033e40b0f8eae623416035e:

  pinctrl: mvebu: new driver for Orion platforms (2014-04-24 15:09:35 +0200)

are available in the git repository at:

  https://github.com/mripard/linux.git tags/sunxi-pinctrl-for-3.16

for you to fetch changes up to dc9691066fa7de51178de5ac3e06b3681557a7b4:

  pinctrl: sunxi: Move the reset handling functions out of the core (2014-05-04 19:57:18 -0500)

----------------------------------------------------------------
Pinctrl cleanup and reworks for 3.16

This serie of patch:
  - Moves the Allwinner pinctrl driver to a folder of its own
  - removes the sunxi-pinctrl-pins header, and split the driver into a core
    one, with all the logic, and smaller drivers, one for each SoC, that
    declare the pins, and will provide to the core the set of pins.
  - And does a few cleanups here and there.

----------------------------------------------------------------
Maxime Ripard (14):
      pinctrl: sunxi: Add const qualifier to the pin descriptor
      pinctrl: sunxi: Drop unused structure members
      pinctrl: sunxi: Move the Allwinner pinctrl driver to its own directory
      pinctrl: sunxi: Replace hardcoded pin defines by a macro
      pinctrl: sunxi: Switch to devm_ioremap_resource
      pinctrl: sunxi: Libraryse the driver
      pinctrl: sunxi: Move Allwinner A10 pinctrl driver to a driver of its own
      pinctrl: sunxi: Move Allwinner A10s pinctrl driver to a driver of its own
      pinctrl: sunxi: Move Allwinner A13 pinctrl driver to a driver of its own
      pinctrl: sunxi: Move Allwinner A31 pinctrl driver to a driver of its own
      pinctrl: sunxi: Move Allwinner A31 special pins driver to a driver of its own
      pinctrl: sunxi: Move Allwinner A20 pinctrl driver to a driver of its own
      pinctrl: sunxi: Introduce per-driver Kconfig options
      pinctrl: sunxi: Move the reset handling functions out of the core

 drivers/pinctrl/Kconfig                     |    6 +-
 drivers/pinctrl/Makefile                    |    2 +-
 drivers/pinctrl/pinctrl-sunxi-pins.h        | 3937 ---------------------------
 drivers/pinctrl/pinctrl-sunxi.h             |  617 -----
 drivers/pinctrl/sunxi/Kconfig               |   32 +
 drivers/pinctrl/sunxi/Makefile              |   10 +
 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c   | 1039 +++++++
 drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c  |  690 +++++
 drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c   |  411 +++
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c |  141 +
 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c   |  865 ++++++
 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c   | 1065 ++++++++
 drivers/pinctrl/{ => sunxi}/pinctrl-sunxi.c |   62 +-
 drivers/pinctrl/sunxi/pinctrl-sunxi.h       |  258 ++
 14 files changed, 4524 insertions(+), 4611 deletions(-)
 delete mode 100644 drivers/pinctrl/pinctrl-sunxi-pins.h
 delete mode 100644 drivers/pinctrl/pinctrl-sunxi.h
 create mode 100644 drivers/pinctrl/sunxi/Kconfig
 create mode 100644 drivers/pinctrl/sunxi/Makefile
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun4i-a10.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun5i-a10s.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun5i-a13.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun6i-a31-r.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun6i-a31.c
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sun7i-a20.c
 rename drivers/pinctrl/{ => sunxi}/pinctrl-sunxi.c (92%)
 create mode 100644 drivers/pinctrl/sunxi/pinctrl-sunxi.h

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140508/60d2653b/attachment.sig>
