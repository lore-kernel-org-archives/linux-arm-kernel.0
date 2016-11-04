From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 4 Nov 2016 11:55:33 +0530
Subject: [GIT PULL 2/4] DaVinci SoC updates for v4.10
In-Reply-To: <20161104062535.9593-1-nsekhar@ti.com>
References: <20161104062535.9593-1-nsekhar@ti.com>
Message-ID: <20161104062535.9593-2-nsekhar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 766763dbdc1dca11deabdb00077a1c19e2803f0a:

  ARM: davinci: da8xx: Remove duplicated defines (2016-10-31 16:51:56 +0530)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nsekhar/linux-davinci.git tags/davinci-for-v4.10/soc

for you to fetch changes up to ced95ac0815501f47a6041548d70d8900400912d:

  ARM: davinci: da8xx: register USB PHY clocks in the DT file (2016-11-01 15:24:24 +0530)

----------------------------------------------------------------
DaVinci SoC support improvements mainly towards an effort to
get to working USB support.

- use CFGCHIP syscon device to access common registers

- define platform data and device tree nodes for newly
  introduced USB phy driver

- clock lookup and auxdata lookup for USB phy and also
  for LCDC (LCD controller)

----------------------------------------------------------------
Axel Haslam (2):
      ARM: davinci: da8xx: Add full regulator constraints for non-DT boot
      ARM: davinci: da8xx: register USB PHY clocks in the DT file

David Lechner (5):
      ARM: davinci: da8xx: Add CFGCHIP syscon platform device
      ARM: davinci: da8xx: Add USB PHY platform device
      ARM: davinci: da8xx: Add USB device names to clock lookup tables
      ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for USB phy
      ARM: davinci: da8xx: add usb phy clocks

Karl Beldan (1):
      ARM: davinci: da8xx-dt: add OF_DEV_AUXDATA entry for lcdc

 arch/arm/mach-davinci/board-da830-evm.c     |  55 +++---
 arch/arm/mach-davinci/board-da850-evm.c     |   4 +
 arch/arm/mach-davinci/board-mityomapl138.c  |   4 +
 arch/arm/mach-davinci/board-omapl138-hawk.c |  27 ++-
 arch/arm/mach-davinci/da830.c               |   4 +-
 arch/arm/mach-davinci/da850.c               |   4 +-
 arch/arm/mach-davinci/da8xx-dt.c            |  15 ++
 arch/arm/mach-davinci/devices-da8xx.c       |  28 +++
 arch/arm/mach-davinci/include/mach/da8xx.h  |   6 +
 arch/arm/mach-davinci/usb-da8xx.c           | 276 ++++++++++++++++++++++++++--
 10 files changed, 366 insertions(+), 57 deletions(-)
