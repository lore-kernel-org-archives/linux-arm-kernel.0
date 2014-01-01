From: shc_work@mail.ru (Alexander Shiyan)
Date: Wed,  1 Jan 2014 10:08:08 +0400
Subject: [PATCH 0/2] spi: clps711x: SPI driver refactor
Message-ID: <1388556488-10887-1-git-send-email-shc_work@mail.ru>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a complex patch for refactoring CLPS711X SPI driver
as a next step to adding DT support for this platform.
Major changes:
- Eliminate <mach/hardware.h> usage.
- Devicetree support.

Since we do not have any platform users of this driver,
non-DT support is removed. DT users will be introduced later
once DT support for this platform will be completed.
"ACK" from arm-soc maintainers will be useful here.

Alexander Shiyan (2):
  spi: clps711x: Driver refactor
  spi: clps711x: dts: Add bindings documentation for the CLPS711X SPI

 .../devicetree/bindings/spi/spi-clps711x.txt       |  22 ++
 drivers/spi/Kconfig                                |   2 +-
 drivers/spi/spi-clps711x.c                         | 233 ++++++++-------------
 include/linux/platform_data/spi-clps711x.h         |  21 --
 4 files changed, 106 insertions(+), 172 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/spi/spi-clps711x.txt
 delete mode 100644 include/linux/platform_data/spi-clps711x.h

-- 
1.8.3.2
