From: baruch@tkos.co.il (Baruch Siach)
Date: Wed, 27 Jan 2010 15:00:46 +0200
Subject: [PATCH 0/3] RTC driver for i.MX25
Message-ID: <cover.1264596212.git.baruch@tkos.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches add support for the RTC of the i.MX25 chip, which is based on the 
DryIce block. The driver is based on code from the Freescale i.MX BSP.

Also included platform code for i.MX25 chip, and the i.MX25 PDK board.

These patches have been tested on the i.MX25 PDK board.

Baruch Siach (3):
  rtc: driver for the DryIce block found in i.MX25 chips
  mx25: add support for the DryIce rtc
  mx25pdk: platform code for the DryIce RTC module

 arch/arm/mach-mx25/clock.c            |    2 +
 arch/arm/mach-mx25/devices.c          |   19 ++
 arch/arm/mach-mx25/devices.h          |    1 +
 arch/arm/mach-mx25/mx25pdk.c          |    1 +
 arch/arm/plat-mxc/include/mach/mx25.h |    2 +
 drivers/rtc/Kconfig                   |   10 +
 drivers/rtc/Makefile                  |    1 +
 drivers/rtc/rtc-imxdi.c               |  559 +++++++++++++++++++++++++++++++++
 8 files changed, 595 insertions(+), 0 deletions(-)
 create mode 100644 drivers/rtc/rtc-imxdi.c
