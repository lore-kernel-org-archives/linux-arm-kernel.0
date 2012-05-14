From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Mon, 14 May 2012 09:47:33 +0800
Subject: [GIT PULL][for 3.5] pull request of dt branch in arch-pxa
Message-ID: <CAN1soZxvoVxJbD_iPjTH78yxzHCgTgMGMCAwTY7CHsshtDok4Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof & Arnd,

Please help to merge dt branch in arch-pxa tree.

The following changes since commit 69964ea4c7b68c9399f7977aa5b9aa6539a6a98a:

  Linux 3.4-rc5 (2012-04-29 15:19:10 -0700)

are available in the git repository at:
  git://github.com/hzhuang1/linux.git dt

Haojian Zhuang (9):
      ARM: mmp: fix build issue on mmp with device tree
      ARM: mmp: append CONFIG_MACH_MMP2_DT
      ARM: mmp: support DT in irq
      ARM: mmp: support DT in timer
      gpio: pxa: parse gpio from DTS file
      ARM: mmp: support mmp2 with device tree
      ARM: mmp: support pxa910 with device tree
      ARM: dts: refresh dts file for arch mmp
      Documentation: update docs for mmp dt

 .../devicetree/bindings/arm/mrvl/intc.txt          |   40 ++
 .../devicetree/bindings/arm/{ => mrvl}/mrvl.txt    |    8 +
 .../devicetree/bindings/arm/mrvl/timer.txt         |   13 +
 .../devicetree/bindings/gpio/mrvl-gpio.txt         |   18 +-
 Documentation/devicetree/bindings/i2c/mrvl-i2c.txt |   15 +-
 arch/arm/Kconfig                                   |    1 +
 arch/arm/boot/dts/mmp2-brownstone.dts              |   38 ++
 arch/arm/boot/dts/mmp2.dtsi                        |  220 ++++++++++
 arch/arm/boot/dts/pxa168.dtsi                      |   67 +++-
 arch/arm/boot/dts/pxa910-dkb.dts                   |   38 ++
 arch/arm/boot/dts/pxa910.dtsi                      |  140 ++++++
 arch/arm/mach-mmp/Kconfig                          |   29 +-
 arch/arm/mach-mmp/Makefile                         |    9 +-
 arch/arm/mach-mmp/include/mach/entry-macro.S       |    4 +-
 arch/arm/mach-mmp/include/mach/irqs.h              |   27 +-
 arch/arm/mach-mmp/irq-mmp2.c                       |  158 -------
 arch/arm/mach-mmp/irq-pxa168.c                     |   54 ---
 arch/arm/mach-mmp/irq.c                            |  445 ++++++++++++++++++++
 arch/arm/mach-mmp/mmp-dt.c                         |   66 ++--
 arch/arm/mach-mmp/mmp2-dt.c                        |   60 +++
 arch/arm/mach-mmp/time.c                           |   81 +++-
 drivers/gpio/gpio-pxa.c                            |  116 +++++-
 22 files changed, 1313 insertions(+), 334 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl/intc.txt
 rename Documentation/devicetree/bindings/arm/{ => mrvl}/mrvl.txt (53%)
 create mode 100644 Documentation/devicetree/bindings/arm/mrvl/timer.txt
 create mode 100644 arch/arm/boot/dts/mmp2-brownstone.dts
 create mode 100644 arch/arm/boot/dts/mmp2.dtsi
 create mode 100644 arch/arm/boot/dts/pxa910-dkb.dts
 create mode 100644 arch/arm/boot/dts/pxa910.dtsi
 delete mode 100644 arch/arm/mach-mmp/irq-mmp2.c
 delete mode 100644 arch/arm/mach-mmp/irq-pxa168.c
 create mode 100644 arch/arm/mach-mmp/irq.c
 create mode 100644 arch/arm/mach-mmp/mmp2-dt.c

Regards
Haojian
