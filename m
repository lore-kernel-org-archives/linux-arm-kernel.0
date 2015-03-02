From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon,  2 Mar 2015 22:12:42 +0100
Subject: [PATCH 0/9] ARM: at91 cleanups for 4.1 #1
Message-ID: <1425330771-23046-1-git-send-email-alexandre.belloni@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This series removes more mach/headers.

Then it introduces a more scalable SoC detection infrastructure which allows to
remove the at91_map_io/at91_alt_map_io and iotable_init ugliness.

Alexandre Belloni (7):
  ARM: at91: remove unused at91_ioremap_matrix and header
  ARM: at91: remove unused _matrix.h headers
  ARM: at91/dt: introduce atmel,<chip>-dbgu
  ARM: at91: at91rm9200 use SoC detection infrastructure
  ARM: at91: at91sam9: use SoC detection infrastructure
  ARM: at91: sama5 use SoC detection infrastructure
  ARM: at91: remove old setup

Arnd Bergmann (1):
  ARM: at91: remove NEED_MACH_IO_H

Boris BREZILLON (1):
  ARM: at91: add soc detection infrastructure

 .../devicetree/bindings/serial/atmel-usart.txt     |   3 +-
 arch/arm/Kconfig                                   |   2 +-
 arch/arm/boot/dts/at91rm9200.dtsi                  |   2 +-
 arch/arm/boot/dts/at91sam9260.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9261.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9263.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9g45.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9n12.dtsi                 |   2 +-
 arch/arm/boot/dts/at91sam9rl.dtsi                  |   2 +-
 arch/arm/boot/dts/at91sam9x5.dtsi                  |   2 +-
 arch/arm/boot/dts/sama5d3.dtsi                     |   2 +-
 arch/arm/boot/dts/sama5d4.dtsi                     |   2 +-
 arch/arm/mach-at91/Kconfig                         |   1 +
 arch/arm/mach-at91/Makefile                        |   2 +-
 arch/arm/mach-at91/at91rm9200.c                    |  34 ++-
 arch/arm/mach-at91/at91sam9.c                      |  94 ++++--
 arch/arm/mach-at91/generic.h                       |   4 -
 arch/arm/mach-at91/include/mach/at91_matrix.h      |  23 --
 .../mach-at91/include/mach/at91sam9260_matrix.h    |  80 -----
 .../mach-at91/include/mach/at91sam9261_matrix.h    |  64 ----
 .../mach-at91/include/mach/at91sam9263_matrix.h    | 129 --------
 .../mach-at91/include/mach/at91sam9g45_matrix.h    | 153 ----------
 .../mach-at91/include/mach/at91sam9n12_matrix.h    |  53 ----
 .../arm/mach-at91/include/mach/at91sam9rl_matrix.h |  96 ------
 .../arm/mach-at91/include/mach/at91sam9x5_matrix.h |  53 ----
 arch/arm/mach-at91/include/mach/io.h               |  27 --
 arch/arm/mach-at91/sama5.c                         |  54 +++-
 arch/arm/mach-at91/setup.c                         | 330 ---------------------
 arch/arm/mach-at91/soc.c                           | 109 +++++++
 arch/arm/mach-at91/soc.h                           |  95 ++++++
 drivers/pcmcia/Kconfig                             |   1 +
 drivers/pcmcia/at91_cf.c                           |  13 +-
 32 files changed, 358 insertions(+), 1082 deletions(-)
 delete mode 100644 arch/arm/mach-at91/include/mach/at91_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9260_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9261_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9263_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9g45_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9n12_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9rl_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/at91sam9x5_matrix.h
 delete mode 100644 arch/arm/mach-at91/include/mach/io.h
 delete mode 100644 arch/arm/mach-at91/setup.c
 create mode 100644 arch/arm/mach-at91/soc.c
 create mode 100644 arch/arm/mach-at91/soc.h

-- 
2.1.0
