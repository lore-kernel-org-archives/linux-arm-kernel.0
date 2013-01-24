From: 21cnbao@gmail.com (Barry Song)
Date: Thu, 24 Jan 2013 11:21:02 +0800
Subject: [GIT PULL] CSR SiRFmarco SoC infrastructures for 3.9
Message-ID: <CAGsJ_4z-7z8=3xQwU6iEsqHEcVrRWK+Fm7eoBEbjC-EAewGypA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Olof, Arnd,

pls pull the following changes for CSR SiRFmarco SoC. it has been
rebased againest arm-soc timer/cleanup tree.

since commit 90cf214d6a549bf482e3c5751ee256cc885b96ea:

  ARM: at91: fix board-rm9200-dt after sys_timer conversion
(2013-01-14 10:14:04 -0800)

are available in the git repository at:
  git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git
marco-timer-cleanup-rebase

Barry Song (9):
      ARM: PRIMA2: add CSR SiRFmarco device tree .dts
      ARM: PRIMA2: enable AUTO_ZRELADDR for SIRF in Kconfig
      ARM: PRIMA2: initialize l2x0 according to mach from DT
      ARM: PRIMA2: mv timer to timer-prima2 as we will add timer-marco
      ARM: PRIMA2: rstc: enable the support for Marco
      ARM: PRIMA2: rtciobg: it is also compatible with marco
      ARM: PRIMA2: irq: make prima2 irq can work even we enable GIC for Marco
      ARM: PRIMA2: add new SiRFmarco SMP SoC infrastructures
      ARM: PRIMA2: provide two DEBUG_LL ports for prima2 and marco

 Documentation/devicetree/bindings/arm/sirf.txt   |   10 +-
 arch/arm/Kconfig                                 |    1 +
 arch/arm/Kconfig.debug                           |   14 +
 arch/arm/boot/dts/Makefile                       |    1 +
 arch/arm/boot/dts/marco-evb.dts                  |   54 ++
 arch/arm/boot/dts/marco.dtsi                     |  756 ++++++++++++++++++++++
 arch/arm/configs/prima2_defconfig                |    3 +
 arch/arm/mach-prima2/Kconfig                     |   10 +
 arch/arm/mach-prima2/Makefile                    |    5 +-
 arch/arm/mach-prima2/common.c                    |   45 ++-
 arch/arm/mach-prima2/common.h                    |   15 +-
 arch/arm/mach-prima2/headsmp.S                   |   79 +++
 arch/arm/mach-prima2/hotplug.c                   |   41 ++
 arch/arm/mach-prima2/include/mach/irqs.h         |    4 +-
 arch/arm/mach-prima2/include/mach/uart.h         |    6 +
 arch/arm/mach-prima2/include/mach/uncompress.h   |    3 +
 arch/arm/mach-prima2/irq.c                       |   16 +-
 arch/arm/mach-prima2/l2x0.c                      |   29 +-
 arch/arm/mach-prima2/platsmp.c                   |  163 +++++
 arch/arm/mach-prima2/rstc.c                      |   45 +-
 arch/arm/mach-prima2/rtciobrg.c                  |    1 +
 arch/arm/mach-prima2/timer-marco.c               |  316 +++++++++
 arch/arm/mach-prima2/{timer.c => timer-prima2.c} |    6 +-
 23 files changed, 1588 insertions(+), 35 deletions(-)
 create mode 100644 arch/arm/boot/dts/marco-evb.dts
 create mode 100644 arch/arm/boot/dts/marco.dtsi
 create mode 100644 arch/arm/mach-prima2/headsmp.S
 create mode 100644 arch/arm/mach-prima2/hotplug.c
 create mode 100644 arch/arm/mach-prima2/platsmp.c
 create mode 100644 arch/arm/mach-prima2/timer-marco.c
 rename arch/arm/mach-prima2/{timer.c => timer-prima2.c} (98%)

Thanks
barry
