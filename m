From: horms+renesas@verge.net.au (Simon Horman)
Date: Tue,  1 Oct 2013 11:34:09 +0900
Subject: [GIT PULL 0/8] Renesas ARM based SoC updates for v3.13
Message-ID: <cover.1380530437.git.horms+renesas@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin, Olof and Arnd,

please consider these Renesas ARM based SoC updates for v3.13.

This pull-request is based on v3.12-rc1.


The following changes since commit 272b98c6455f00884f0350f775c5342358ebb73f:

  Linux 3.12-rc1 (2013-09-16 16:17:51 -0400)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git soc

for you to fetch changes up to f39d35fcc2cd7a24ec3128adffd7876953999e1f:

  ARM: shmobile: r8a7778: add usb phy power control function (2013-09-30 16:11:23 +0900)

----------------------------------------------------------------
Renesas ARM based SoC updates for v3.13

* Add support for r8a7791 SoC
* Rename DU device in clock lookups list of r8a7779 SoC
* USB and SSI/SRU clock support for r8a7778 SoC
* USB phy power control function support for r8a7778 SoC

----------------------------------------------------------------
Hisashi Nakamura (1):
      ARM: shmobile: Initial r8a7791 SoC support

Kuninori Morimoto (3):
      ARM: shmobile: r8a7778: add SSI/SRU clock support
      ARM: shmobile: r8a7778: add USBHS clock
      ARM: shmobile: r8a7778: add usb phy power control function

Laurent Pinchart (2):
      ARM: shmobile: r8a7779: Rename DU device in clock lookups list
      ARM: shmobile: r8a7790: Add DU and LVDS clocks

Magnus Damm (1):
      ARM: shmobile: r8a7791 CMT support

Yoshikazu Fujikawa (1):
      ARM: shmobile: r8a7791 SCIF support

 arch/arm/boot/dts/r8a7791.dtsi                |  41 +++++
 arch/arm/mach-shmobile/Kconfig                |   6 +
 arch/arm/mach-shmobile/Makefile               |   2 +
 arch/arm/mach-shmobile/clock-r8a7778.c        |  44 ++++-
 arch/arm/mach-shmobile/clock-r8a7779.c        |   2 +-
 arch/arm/mach-shmobile/clock-r8a7790.c        |  12 +-
 arch/arm/mach-shmobile/clock-r8a7791.c        | 237 ++++++++++++++++++++++++++
 arch/arm/mach-shmobile/include/mach/r8a7778.h |   2 +
 arch/arm/mach-shmobile/include/mach/r8a7791.h |   8 +
 arch/arm/mach-shmobile/setup-r8a7778.c        |  37 ++--
 arch/arm/mach-shmobile/setup-r8a7791.c        | 149 ++++++++++++++++
 11 files changed, 525 insertions(+), 15 deletions(-)
 create mode 100644 arch/arm/boot/dts/r8a7791.dtsi
 create mode 100644 arch/arm/mach-shmobile/clock-r8a7791.c
 create mode 100644 arch/arm/mach-shmobile/include/mach/r8a7791.h
 create mode 100644 arch/arm/mach-shmobile/setup-r8a7791.c
