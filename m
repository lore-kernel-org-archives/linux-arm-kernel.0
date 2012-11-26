From: horms@verge.net.au (Simon Horman)
Date: Mon, 26 Nov 2012 09:16:47 +0900
Subject: [PATCH 0/7] ARM: mach-shmobile: kzm9g: Reference DT implementation
Message-ID: <1353889014-17142-1-git-send-email-horms@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Magnus, Hi all,

this series is a first pass at providing a refernce DT implementation
for the kzm9g baord which is intended to act as a guide for mach-shmobile
developers.

The first two patches of the series make minor modifications to the mmcif
and sdhi drivers to allow registration of those devices using device
tree on the KZM9G board.

The following three patches enhance sh77a0 SoC support to allow minimal
registratioj using device tree.

The final patch adds a fresh board and dts file which initialises the
kfm9g board using device tree as much as possible.

Simon Horman (7):
  mmc: sh-mmcif: provide default allowed voltage
  mmc: sdhi: enchance OF support for flags and cd-gpios
  sh: pfc: Allow device tree registration
  ARM: shmobile: pfc-sh73a0: Register device tree
  ARM: mach-shmobile: sh73a0: Allow initialisation of GIC by DT
  ARM: mach-shmobile: sh73a0: Minimal setup using DT
  ARM: mach-shmobile: kzm9g: Reference DT implementation

 arch/arm/boot/dts/Makefile                     |    3 +-
 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts   |  153 ++++++++++++++++++++++++
 arch/arm/mach-shmobile/Kconfig                 |   10 ++
 arch/arm/mach-shmobile/Makefile                |    8 +-
 arch/arm/mach-shmobile/board-kzm9g-reference.c |  142 ++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/common.h   |    3 +
 arch/arm/mach-shmobile/intc-sh73a0.c           |   14 +++
 arch/arm/mach-shmobile/pfc-sh73a0.c            |   45 +++++++
 arch/arm/mach-shmobile/setup-sh73a0.c          |   41 ++++++-
 drivers/mmc/host/sh_mmcif.c                    |    7 +-
 drivers/mmc/host/sh_mobile_sdhi.c              |   76 ++++++++++--
 drivers/sh/pfc/gpio.c                          |   15 +++
 include/linux/sh_pfc.h                         |    7 ++
 13 files changed, 501 insertions(+), 23 deletions(-)
 create mode 100644 arch/arm/boot/dts/sh73a0-kzm9g-reference.dts
 create mode 100644 arch/arm/mach-shmobile/board-kzm9g-reference.c

-- 
1.7.10.4
