From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 26 Jan 2012 18:12:31 +0100
Subject: [PATCH 0/6] ARM: at91: at91sam9x5 family basic support
Message-ID: <1327597957-32662-1-git-send-email-nicolas.ferre@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The at91sam9x5 family is an ARM926 based SoC family from Atmel.
five different products are available: sam9g15, sam9g25, sam9g35
sam9x25 and sam9x35.
Evaluation Kits are composed of a CPU Module and a carrier board (with
optional screen).
The use of the Device Tree is reducing the amount of code needed for
an AT91 based SoC: sam9x5 are the first AT91 SoC that only rely on
DT for their hardware configuration.

 arch/arm/boot/dts/at91sam9g25ek.dts                |   37 ++
 arch/arm/boot/dts/at91sam9x5.dtsi                  |  172 +++++++++
 arch/arm/boot/dts/at91sam9x5cm.dtsi                |   14 +
 arch/arm/mach-at91/Kconfig                         |    9 +
 arch/arm/mach-at91/Makefile                        |    1 +
 arch/arm/mach-at91/at91sam9x5.c                    |  373 ++++++++++++++++++++
 arch/arm/mach-at91/board-dt.c                      |    1 +
 arch/arm/mach-at91/clock.c                         |   83 ++++-
 arch/arm/mach-at91/include/mach/at91_pmc.h         |   60 +++-
 arch/arm/mach-at91/include/mach/at91sam9x5.h       |   80 +++++
 .../arm/mach-at91/include/mach/at91sam9x5_matrix.h |   53 +++
 arch/arm/mach-at91/include/mach/hardware.h         |    2 +
 12 files changed, 854 insertions(+), 31 deletions(-)
 create mode 100644 arch/arm/boot/dts/at91sam9g25ek.dts
 create mode 100644 arch/arm/boot/dts/at91sam9x5.dtsi
 create mode 100644 arch/arm/boot/dts/at91sam9x5cm.dtsi
 create mode 100644 arch/arm/mach-at91/at91sam9x5.c
 create mode 100644 arch/arm/mach-at91/include/mach/at91sam9x5.h
 create mode 100644 arch/arm/mach-at91/include/mach/at91sam9x5_matrix.h
