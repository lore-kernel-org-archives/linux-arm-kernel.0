From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Tue, 8 May 2012 10:22:58 +0800
Subject: [GIT PULL][for 3.5] pull request of board-specific branch in arch-pxa
 git tree
Message-ID: <CAN1soZzgO7yKfPM8wx9-8i85iq1OW=FxfjRFsOpGd4A_eiyqDQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to pull board-specific branch in arch-pxa git tree.

The following changes since commit d48b97b403d23f6df0b990cee652bdf9a52337a3:

  Linux 3.4-rc6 (2012-05-06 15:07:32 -0700)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git board-specific

Neil Zhang (4):
      ARM: mmp: add usb device support for PXA910
      ARM: mmp: add usb device support for ttc dkb
      ARM: mmp: add usb host support for PXA168
      ARM: mmp: add usb host support for aspen

Paul Parsons (5):
      ARM: pxa: hx4700: Initialize DS1WM clock_rate
      ARM: pxa: hx4700: Enable ASIC3 GPIO as a wakeup source
      ARM: pxa: hx4700: Add PCMCIA/CF support
      ARM: pxa: Add standard UART to hx4700_pin_config[]
      pcmcia: add driver for hx4700

Robert Jarzmik (1):
      ARM: pxa: mioa701 add camera output enable gpio

Sascha Hauer (1):
      ARM: pxa: use ioremap to access CPLD

 arch/arm/mach-mmp/Kconfig                         |    7 +
 arch/arm/mach-mmp/aspenite.c                      |   20 ++
 arch/arm/mach-mmp/devices.c                       |  282 +++++++++++++++++++++
 arch/arm/mach-mmp/include/mach/devices.h          |    3 +
 arch/arm/mach-mmp/include/mach/pxa168.h           |    8 +-
 arch/arm/mach-mmp/include/mach/pxa910.h           |    3 +
 arch/arm/mach-mmp/include/mach/regs-usb.h         |  253 ++++++++++++++++++
 arch/arm/mach-mmp/pxa168.c                        |   20 +-
 arch/arm/mach-mmp/pxa910.c                        |    2 +-
 arch/arm/mach-mmp/ttc_dkb.c                       |   37 +++
 arch/arm/mach-pxa/hx4700.c                        |   10 +-
 arch/arm/mach-pxa/include/mach/mioa701.h          |    3 +
 arch/arm/mach-pxa/include/mach/pcm990_baseboard.h |   68 +-----
 arch/arm/mach-pxa/mioa701.c                       |    2 +
 arch/arm/mach-pxa/pcm990-baseboard.c              |   83 ++++---
 drivers/pcmcia/Kconfig                            |    2 +-
 drivers/pcmcia/Makefile                           |    1 +
 drivers/pcmcia/pxa2xx_hx4700.c                    |  121 +++++++++
 include/linux/mfd/asic3.h                         |    1 +
 19 files changed, 809 insertions(+), 117 deletions(-)
 create mode 100644 arch/arm/mach-mmp/include/mach/regs-usb.h
 create mode 100644 drivers/pcmcia/pxa2xx_hx4700.c
