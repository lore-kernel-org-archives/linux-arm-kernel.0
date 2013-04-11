From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Thu, 11 Apr 2013 10:30:30 +0800
Subject: [GIT PULL][for 3.10] pull request from armsoc/pxa branch in pxa git
 tree
Message-ID: <CAN1soZzqag7W3Yz07-2KV-4BVd1eN0dYMiFhsg6+NEc1hRZKjg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd & Olof,

Please help to merge armsoc/pxa branch from pxa git tree.

Regards
Haojian

The following changes since commit 31880c37c11e28cb81c70757e38392b42e695dc6:

  Linux 3.9-rc6 (2013-04-07 20:49:54 -0700)

are available in the git repository at:

  git://github.com/hzhuang1/linux.git armsoc/pxa

for you to fetch changes up to 0a43cd3b1cc1b7e1dfc461cf55b414610d038769:

  ARM: pxa: move debug uart code (2013-04-11 10:02:31 +0800)

----------------------------------------------------------------
Haojian Zhuang (5):
      ARM: pxa: remove cpu_is_xxx in gpio driver
      ARM: pxa: move PXA_GPIO_TO_IRQ macro
      ARM: mmp: add more compatible names in gpio driver
      ARM: pxa: select PXA935 on saar & tavorevb
      ARM: pxa: move debug uart code

 Documentation/devicetree/bindings/gpio/mrvl-gpio.txt |    7 +++--
 arch/arm/Kconfig.debug                               |    9 ++++++
 arch/arm/boot/dts/mmp2.dtsi                          |    2 +-
 arch/arm/boot/dts/pxa168.dtsi                        |    2 +-
 arch/arm/boot/dts/pxa910.dtsi                        |    2 +-
 arch/arm/include/debug/pxa.S                         |   33
++++++++++++++++++++
 arch/arm/mach-mmp/aspenite.c                         |    7 +++++
 arch/arm/mach-mmp/avengers_lite.c                    |    7 +++++
 arch/arm/mach-mmp/brownstone.c                       |    7 +++++
 arch/arm/mach-mmp/clock-mmp2.c                       |    2 +-
 arch/arm/mach-mmp/clock-pxa168.c                     |    2 +-
 arch/arm/mach-mmp/clock-pxa910.c                     |    2 +-
 arch/arm/mach-mmp/flint.c                            |    7 +++++
 arch/arm/mach-mmp/gplugd.c                           |    7 +++++
 arch/arm/mach-mmp/include/mach/debug-macro.S         |   30 ------------------
 arch/arm/mach-mmp/jasper.c                           |    8 +++++
 arch/arm/mach-mmp/mmp-dt.c                           |    4 +--
 arch/arm/mach-mmp/mmp2-dt.c                          |    2 +-
 arch/arm/mach-mmp/mmp2.c                             |    2 +-
 arch/arm/mach-mmp/pxa168.c                           |    2 +-
 arch/arm/mach-mmp/pxa910.c                           |    2 +-
 arch/arm/mach-mmp/tavorevb.c                         |    7 +++++
 arch/arm/mach-mmp/teton_bga.c                        |    7 +++++
 arch/arm/mach-mmp/ttc_dkb.c                          |    7 +++++
 arch/arm/mach-pxa/Kconfig                            |    2 ++
 arch/arm/mach-pxa/devices.c                          |   29 +++++++++++++++--
 arch/arm/mach-pxa/devices.h                          |    6 +++-
 arch/arm/mach-pxa/include/mach/debug-macro.S         |   23 --------------
 arch/arm/mach-pxa/pxa25x.c                           |   11 +++++--
 arch/arm/mach-pxa/pxa27x.c                           |    7 +++--
 arch/arm/mach-pxa/pxa3xx.c                           |   23 +++++++++++---
 arch/arm/mach-pxa/pxa930.c                           |   17 ++++++++--
 drivers/clk/mmp/clk-mmp2.c                           |    2 +-
 drivers/clk/mmp/clk-pxa168.c                         |    2 +-
 drivers/clk/mmp/clk-pxa910.c                         |    2 +-
 drivers/gpio/gpio-pxa.c                              |  151
+++++++++++++++++++++++++++++++++++++++++++++++++++++++---------------------------------
 include/linux/gpio-pxa.h                             |    1 +
 37 files changed, 302 insertions(+), 141 deletions(-)
 create mode 100644 arch/arm/include/debug/pxa.S
 delete mode 100644 arch/arm/mach-mmp/include/mach/debug-macro.S
 delete mode 100644 arch/arm/mach-pxa/include/mach/debug-macro.S
