From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Wed, 16 Jan 2013 18:08:09 +0100
Subject: [PATCH 0/8] ARM: shmobile: pinctrl and DT extensions
Message-ID: <1358356097-26180-1-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches extend sh7372 and r8a7740 pinctrl support and use it to add 
SDHI and MMCIF to armadillo800eva and mackerel reference DT 
implementations. GPIO-based pin configuration is removed from board files. 
Additionally, MMC interfaces on armadillo800eva support run-time 
power-switching, which is also supported in DT with these patches.

This series is based on recent work by Laurent and Simon. sh7372 and 
r8a7740 pinctrl support seems to be stable and, probably, won't change, 
so, also the base for these patches seems solid. Since the current pinctrl 
implementation for sh73a0 is likely to change, support for kzm9g isn't 
included in this series.

Guennadi Liakhovetski (8):
  pinctrl: add SDHI and MMCIF pin groups to r8a7740
  pinctrl: add SDHI and MMCIF pin groups to sh7372
  ARM: shmobile: simplify armadillo800eva and kzm9g Kconfig
    dependencies
  ARM: shmobile: add MMCIF and SDHI DT clock aliases to sh73a0 and
    r8a7740
  ARM: shmobile: add a GPIO controller DT node for sh7372
  ARM: shmobile: use GPIO SD-card detection on armadillo800eva
  ARM: shmobile: completely switch MMC interfaces on mackerel-reference
    to DT
  ARM: shmobile: completely switch MMC interfaces on
    armadillo800eva-reference to DT

 .../boot/dts/r8a7740-armadillo800eva-reference.dts |  101 ++++++++++
 arch/arm/boot/dts/sh7372-mackerel-reference.dts    |   42 +++-
 arch/arm/boot/dts/sh7372.dtsi                      |    8 +
 arch/arm/mach-shmobile/Kconfig                     |   12 +-
 .../board-armadillo800eva-reference.c              |    5 +-
 arch/arm/mach-shmobile/board-armadillo800eva.c     |   10 +-
 arch/arm/mach-shmobile/board-mackerel-reference.c  |   46 -----
 arch/arm/mach-shmobile/clock-r8a7740.c             |    4 +
 arch/arm/mach-shmobile/clock-sh73a0.c              |    3 +
 drivers/pinctrl/sh-pfc/pfc-r8a7740.c               |  180 +++++++++++++++++
 drivers/pinctrl/sh-pfc/pfc-sh7372.c                |  205 ++++++++++++++++++++
 11 files changed, 552 insertions(+), 64 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
