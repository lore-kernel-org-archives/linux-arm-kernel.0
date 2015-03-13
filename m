From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Fri, 13 Mar 2015 18:12:29 +0100
Subject: [GIT PULL] at91: cleanup for 4.1 #2
Message-ID: <1426266749-9714-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd, Olof, Kevin,

Another cleanup series on top of the previous one that I sent you this
afternoon ;-) I think it is the last time that we can remove a whole bunch of
files and legacy code... We were getting used to it!
I still have another one dealing with at91rm9200 ST cleanup that I plan to send
early next week (dependencies between trees to solve).

Thanks, best regards,

The following changes since commit 385acc0dac88d79447a03a1363072fc258429dec:

  ARM: at91/pm: flush data cache and clean, invalidate and disable the L2 cache (2015-03-13 13:34:55 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/nferre/linux-at91.git tags/at91-cleanup2

for you to fetch changes up to 598e085590fc5ac1fecff00e842a8a6c2ae010e5:

  ARM: at91: remove old setup (2015-03-13 18:01:10 +0100)

----------------------------------------------------------------
Second batch of cleanup for 4.1:
- remove unused matrix header files
- dbgu + chip identification: new driver for SoC detection
  this allow to remove all additional io mapping
- remove old non-standard AT91 setup code

----------------------------------------------------------------
Alexandre Belloni (8):
      ARM: at91: remove unused at91_ioremap_matrix and header
      ARM: at91: remove unused _matrix.h headers
      ARM: at91/dt: introduce atmel,<chip>-dbgu
      ARM: at91: at91rm9200 use SoC detection infrastructure
      ARM: at91: at91sam9: use SoC detection infrastructure
      ARM: at91: sama5 use SoC detection infrastructure
      ARM: at91: sama5d4: remove useless map_io
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
 arch/arm/mach-at91/at91rm9200.c                    |  29 +-
 arch/arm/mach-at91/at91sam9.c                      |  76 +++--
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
 arch/arm/mach-at91/sama5.c                         |  81 +++--
 arch/arm/mach-at91/setup.c                         | 330 ---------------------
 arch/arm/mach-at91/soc.c                           |  97 ++++++
 arch/arm/mach-at91/soc.h                           |  78 +++++
 drivers/pcmcia/Kconfig                             |   1 +
 drivers/pcmcia/at91_cf.c                           |  13 +-
 32 files changed, 301 insertions(+), 1114 deletions(-)
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
Nicolas Ferre
