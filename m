From: Barry.Song@csr.com (Barry Song)
Date: Mon, 20 Aug 2012 16:19:44 +0800
Subject: [PATCH 0/3] ARM: PRIMA2: some patches prepared to support new SiRF
 SoCs
Message-ID: <1345450787-17246-1-git-send-email-Barry.Song@csr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Barry Song <Baohua.Song@csr.com>

we will support SiRFmarco and SiRFpolo SMP SoCs, this series is making
mach-prima2 common for all of them.

Barry Song (3):
  ARM: PRIMA2: use DT_MACHINE_START and convert to generic board
  ARM: PRIMA2: make mach-prima2 common for all SiRF series SoC
  ARM: SIRF: make sirf irqchip driver selectable since new SoCs will
    have GIC

 arch/arm/Kconfig                                   |   10 +++++-----
 arch/arm/Makefile                                  |    2 +-
 arch/arm/mach-sirf/Kconfig                         |   20 ++++++++++++++++++++
 arch/arm/{mach-prima2 => mach-sirf}/Makefile       |    4 ++--
 arch/arm/{mach-prima2 => mach-sirf}/Makefile.boot  |    0
 .../prima2.c => mach-sirf/board-generic.c}         |   10 ++++++----
 arch/arm/{mach-prima2 => mach-sirf}/common.h       |    0
 .../include/mach/clkdev.h                          |    0
 .../include/mach/debug-macro.S                     |    0
 .../include/mach/entry-macro.S                     |    0
 .../{mach-prima2 => mach-sirf}/include/mach/gpio.h |    0
 .../include/mach/hardware.h                        |    0
 .../{mach-prima2 => mach-sirf}/include/mach/irqs.h |    0
 .../{mach-prima2 => mach-sirf}/include/mach/map.h  |    0
 .../include/mach/timex.h                           |    0
 .../{mach-prima2 => mach-sirf}/include/mach/uart.h |    0
 .../include/mach/uncompress.h                      |    0
 arch/arm/{mach-prima2 => mach-sirf}/irq.c          |    0
 arch/arm/{mach-prima2 => mach-sirf}/l2x0.c         |    0
 arch/arm/{mach-prima2 => mach-sirf}/lluart.c       |    0
 arch/arm/{mach-prima2 => mach-sirf}/pm.c           |    0
 arch/arm/{mach-prima2 => mach-sirf}/pm.h           |    0
 arch/arm/{mach-prima2 => mach-sirf}/rstc.c         |    0
 arch/arm/{mach-prima2 => mach-sirf}/rtciobrg.c     |    0
 arch/arm/{mach-prima2 => mach-sirf}/sleep.S        |    0
 arch/arm/{mach-prima2 => mach-sirf}/timer.c        |    0
 26 files changed, 34 insertions(+), 12 deletions(-)
 create mode 100644 arch/arm/mach-sirf/Kconfig
 rename arch/arm/{mach-prima2 => mach-sirf}/Makefile (73%)
 rename arch/arm/{mach-prima2 => mach-sirf}/Makefile.boot (100%)
 rename arch/arm/{mach-prima2/prima2.c => mach-sirf/board-generic.c} (81%)
 rename arch/arm/{mach-prima2 => mach-sirf}/common.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/clkdev.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/debug-macro.S (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/entry-macro.S (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/gpio.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/hardware.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/irqs.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/map.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/timex.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/uart.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/include/mach/uncompress.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/irq.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/l2x0.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/lluart.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/pm.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/pm.h (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/rstc.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/rtciobrg.c (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/sleep.S (100%)
 rename arch/arm/{mach-prima2 => mach-sirf}/timer.c (100%)



Member of the CSR plc group of companies. CSR plc registered in England and Wales, registered number 4187346, registered office Churchill House, Cambridge Business Park, Cowley Road, Cambridge, CB4 0WZ, United Kingdom
More information can be found at www.csr.com. Follow CSR on Twitter at http://twitter.com/CSR_PLC and read our blog at www.csr.com/blog
