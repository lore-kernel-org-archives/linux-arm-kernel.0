From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 10 Mar 2011 19:06:28 +0100
Subject: at91samx5: support
Message-ID: <20110310180628.GH9351@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

	The following patch series add the basic support
	of the new at91sam9x5 series also known as serie 5

	This will need an update of the mach-type to get the
	MACH_AT91SAM9X5EK

Dan Liang (2):
      AT91: overall definition: add 5series support
      AT91: AT91SAM9x5 processors support

Nicolas Ferre (4):
      AT91: PMC header: add 5series support
      AT91: clock: add 5series chip family support
      AT91: pio: add new PIO3a features
      AT91: at91sam9x5: add chip and board file

 arch/arm/configs/at91sam9x5ek_defconfig            |  180 ++++
 arch/arm/mach-at91/Kconfig                         |   19 +
 arch/arm/mach-at91/Makefile                        |    4 +
 arch/arm/mach-at91/at91sam9x5.c                    |  416 ++++++++
 arch/arm/mach-at91/at91sam9x5_devices.c            | 1083 ++++++++++++++++++++
 arch/arm/mach-at91/board-sam9x5ek.c                |  243 +++++
 arch/arm/mach-at91/clock.c                         |   87 ++-
 arch/arm/mach-at91/generic.h                       |    2 +
 arch/arm/mach-at91/gpio.c                          |  240 ++++-
 arch/arm/mach-at91/include/mach/at91_pio.h         |   25 +
 arch/arm/mach-at91/include/mach/at91_pmc.h         |   63 +-
 arch/arm/mach-at91/include/mach/at91sam9x5.h       |  179 ++++
 .../arm/mach-at91/include/mach/at91sam9x5_matrix.h |  139 +++
 arch/arm/mach-at91/include/mach/board.h            |    2 +-
 arch/arm/mach-at91/include/mach/cpu.h              |   28 +
 arch/arm/mach-at91/include/mach/gpio.h             |    5 +
 arch/arm/mach-at91/include/mach/hardware.h         |    2 +
 arch/arm/mach-at91/include/mach/timex.h            |    5 +
 arch/arm/mach-at91/pm.h                            |   19 +
 arch/arm/mach-at91/pm_slowclock.S                  |   11 +-
 drivers/dma/Kconfig                                |    2 +-
 21 files changed, 2703 insertions(+), 51 deletions(-)
 create mode 100644 arch/arm/configs/at91sam9x5ek_defconfig
 create mode 100644 arch/arm/mach-at91/at91sam9x5.c
 create mode 100644 arch/arm/mach-at91/at91sam9x5_devices.c
 create mode 100644 arch/arm/mach-at91/board-sam9x5ek.c
 create mode 100644 arch/arm/mach-at91/include/mach/at91sam9x5.h
 create mode 100644 arch/arm/mach-at91/include/mach/at91sam9x5_matrix.h

Best Regards,
J.
