From: horms+renesas@verge.net.au (Simon Horman)
Date: Wed, 13 Feb 2013 12:29:12 +0900
Subject: [PATCH v2.1 0/9] SH pinctrl DT support
Message-ID: <1360726161-16072-1-git-send-email-horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

this series is a follow-up to "[PATCH v2 0/8] SH pinctrl DT support"
by Laurent Pinchart. I am primarily posting it for his review.

This series differs from the series posted by Laurent in that:

* I have added the following two patch to update the KZM9G reference code.

  ARM: shmobile: kzm9g: reference: Populate platform devices from device tree

The basis for this series is

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/pinmux-pfc-funcs

  Which was posted as "[PATCH 00/21 v1.2] SCIF, I2C and FSI pinctrl
  functions for sh73a0" a little earlier today.

Laurent, if you want to change this series in any way just let me know.
I can drop patches indidually or drop the entire series and add a fresh
one from you to the topic branch.

Git and diffstat information is provided below to aid review.

----------------------------------------------------------------
The following changes since commit e92460f4d0ce471110d44a3dc053f0a4508f24dc:

  ARM: shmobile: r8a7779: Remove DU function GPIOs (2013-02-13 12:16:13 +0900)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git topic/pinmux-dt

for you to fetch changes up to 3ec7a99ff9723cafabf0eae2df9cac7df735f388:

  ARM: shmobile: kzm9g: Move pinctrl mappings to device tree (2013-02-13 12:19:04 +0900)

----------------------------------------------------------------
Laurent Pinchart (8):
      sh-pfc: Add OF support
      ARM: shmobile: r8a7740: Add pin control device in device tree
      ARM: shmobile: armadillo: Populate platform devices from device tree
      ARM: shmobile: sh73a0: Add pin control device in device tree
      ARM: shmobile: kzm9g: Populate platform devices from device tree
      ARM: shmobile: kzm9g: Add LED1-LED4 to the device tree
      ARM: shmobile: armadillo: Move pinctrl mappings to device tree
      ARM: shmobile: kzm9g: Move pinctrl mappings to device tree

Simon Horman (1):
      ARM: shmobile: kzm9g: reference: Populate platform devices from device tree

 .../bindings/pinctrl/renesas,pfc-pinctrl.txt       |   77 ++++++++++++++++++++
 arch/arm/boot/dts/r8a7740-armadillo800eva.dts      |   10 +++
 arch/arm/boot/dts/r8a7740.dtsi                     |    8 ++
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts       |   12 +++
 arch/arm/boot/dts/sh73a0-kzm9g.dts                 |   26 +++++++
 arch/arm/boot/dts/sh73a0.dtsi                      |    8 ++
 arch/arm/mach-shmobile/board-armadillo800eva.c     |   14 +---
 arch/arm/mach-shmobile/board-kzm9g-reference.c     |    7 +-
 arch/arm/mach-shmobile/board-kzm9g.c               |   27 +------
 drivers/pinctrl/sh-pfc/core.c                      |   62 +++++++++++++++-
 drivers/pinctrl/sh-pfc/pinctrl.c                   |   54 ++++++++++++++
 11 files changed, 261 insertions(+), 44 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/renesas,pfc-pinctrl.txt
