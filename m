From: 21cnbao@gmail.com (Barry Song)
Date: Sat, 9 Jul 2011 09:40:57 +0800
Subject: [GIT PULL] CSR SiRFprimaII board support for v3.1
Message-ID: <CAGsJ_4zojPGr52mc8Neko1bKmUWTcvA=NcomZA=P1SFTQMMxCA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

Please pull CSR SiRFprimaII board support from:

git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git for-arnd

It is same with v5 patchset I sent in the linux-arm-kernel mail list.
For more comments ongoing/coming and new features, I will work on them
to figure out incremental patches. There are still large number of
work left in mach-prima2, for exmaple, PM, full clock tree, RTC-IOBG
APIs, gpio(now drivers/gpio), pinmux(now drivers/pinmux) and so on.
Those will be continued in the next merge window.

I'd like to say we really appreciate you very much for your great help
on the basic board support of CSR prima2.

Regards,
Barry


The following changes since commit f1bb20a8365f6753e0f7b6e94981ca2b662bae13:
  Linus Torvalds (1):
        Merge branch 'for-30-rc5/all-i2c' of git://git.fluff.org/bjdooks/linux

are available in the git repository at:

  git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git for-arnd

Barry Song (1):
      ARM: CSR: mapping early DEBUG_LL uart

Binghua Duan (1):
      ARM: CSR: Adding CSR SiRFprimaII board support

Rongjun Ying (1):
      ARM: CSR: initializing L2 cache

 Documentation/devicetree/bindings/arm/sirf.txt  |    3 +
 arch/arm/Kconfig                                |   14 +
 arch/arm/Makefile                               |    1 +
 arch/arm/boot/dts/prima2-cb.dts                 |  416 ++++++++++++++++++
 arch/arm/mach-prima2/Makefile                   |    7 +
 arch/arm/mach-prima2/Makefile.boot              |    3 +
 arch/arm/mach-prima2/clock.c                    |  509 +++++++++++++++++++++++
 arch/arm/mach-prima2/common.h                   |   26 ++
 arch/arm/mach-prima2/include/mach/clkdev.h      |   15 +
 arch/arm/mach-prima2/include/mach/debug-macro.S |   29 ++
 arch/arm/mach-prima2/include/mach/entry-macro.S |   29 ++
 arch/arm/mach-prima2/include/mach/hardware.h    |   15 +
 arch/arm/mach-prima2/include/mach/io.h          |   16 +
 arch/arm/mach-prima2/include/mach/irqs.h        |   17 +
 arch/arm/mach-prima2/include/mach/map.h         |   16 +
 arch/arm/mach-prima2/include/mach/memory.h      |   21 +
 arch/arm/mach-prima2/include/mach/system.h      |   29 ++
 arch/arm/mach-prima2/include/mach/timex.h       |   14 +
 arch/arm/mach-prima2/include/mach/uart.h        |   23 +
 arch/arm/mach-prima2/include/mach/uncompress.h  |   40 ++
 arch/arm/mach-prima2/include/mach/vmalloc.h     |   16 +
 arch/arm/mach-prima2/irq.c                      |   71 ++++
 arch/arm/mach-prima2/l2x0.c                     |   59 +++
 arch/arm/mach-prima2/lluart.c                   |   25 ++
 arch/arm/mach-prima2/prima2.c                   |   41 ++
 arch/arm/mach-prima2/rstc.c                     |   69 +++
 arch/arm/mach-prima2/timer.c                    |  217 ++++++++++
 arch/arm/mm/Kconfig                             |    2 +-
 28 files changed, 1742 insertions(+), 1 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/sirf.txt
 create mode 100644 arch/arm/boot/dts/prima2-cb.dts
 create mode 100644 arch/arm/mach-prima2/Makefile
 create mode 100644 arch/arm/mach-prima2/Makefile.boot
 create mode 100644 arch/arm/mach-prima2/clock.c
 create mode 100644 arch/arm/mach-prima2/common.h
 create mode 100644 arch/arm/mach-prima2/include/mach/clkdev.h
 create mode 100644 arch/arm/mach-prima2/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-prima2/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-prima2/include/mach/hardware.h
 create mode 100644 arch/arm/mach-prima2/include/mach/io.h
 create mode 100644 arch/arm/mach-prima2/include/mach/irqs.h
 create mode 100644 arch/arm/mach-prima2/include/mach/map.h
 create mode 100644 arch/arm/mach-prima2/include/mach/memory.h
 create mode 100644 arch/arm/mach-prima2/include/mach/system.h
 create mode 100644 arch/arm/mach-prima2/include/mach/timex.h
 create mode 100644 arch/arm/mach-prima2/include/mach/uart.h
 create mode 100644 arch/arm/mach-prima2/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-prima2/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-prima2/irq.c
 create mode 100644 arch/arm/mach-prima2/l2x0.c
 create mode 100644 arch/arm/mach-prima2/lluart.c
 create mode 100644 arch/arm/mach-prima2/prima2.c
 create mode 100644 arch/arm/mach-prima2/rstc.c
 create mode 100644 arch/arm/mach-prima2/timer.c
