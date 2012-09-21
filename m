From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Sep 2012 10:35:30 +0100
Subject: [RFC 0/3] Move some ARM header files to more appropriate locations
Message-ID: <20120921093530.GB31374@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series moves some of the misplaced ARM header files, which
contain driver platform data, out of arch/arm/include/asm/mach
and into include/linux/platform_data.

arch/arm/include/asm/mach is supposed to be for include files
exporting generic ARM code structures and functions to ARM platforms,
not for platforms to export platform data definitions to the rest
of the kernel.

This patch series addresses three of the files: the SA11x0 serial
driver platform data, the PXA2xx UDC driver, and the Atmel serial
driver.  Out of those three, I ended up deleting the Atmel serial
driver header as I could not find any user of the exported function
and its data structure anywhere in the kernel.

 arch/arm/include/asm/mach/serial_at91.h            |   33 --------------------
 arch/arm/mach-ixp4xx/include/mach/udc.h            |    2 +-
 arch/arm/mach-pxa/include/mach/udc.h               |    2 +-
 arch/arm/mach-sa1100/assabet.c                     |    2 +-
 arch/arm/mach-sa1100/badge4.c                      |    2 +-
 arch/arm/mach-sa1100/cerf.c                        |    2 +-
 arch/arm/mach-sa1100/collie.c                      |    2 +-
 arch/arm/mach-sa1100/h3xxx.c                       |    2 +-
 arch/arm/mach-sa1100/hackkit.c                     |    2 +-
 arch/arm/mach-sa1100/jornada720.c                  |    2 +-
 arch/arm/mach-sa1100/lart.c                        |    2 +-
 arch/arm/mach-sa1100/nanoengine.c                  |    2 +-
 arch/arm/mach-sa1100/neponset.c                    |    2 +-
 arch/arm/mach-sa1100/pleb.c                        |    2 +-
 arch/arm/mach-sa1100/shannon.c                     |    2 +-
 arch/arm/mach-sa1100/simpad.c                      |    2 +-
 arch/avr32/include/asm/mach/serial_at91.h          |   33 --------------------
 drivers/tty/serial/atmel_serial.c                  |   18 -----------
 drivers/tty/serial/sa1100.c                        |    2 +-
 drivers/usb/gadget/pxa25x_udc.c                    |    4 +--
 .../linux/platform_data/pxa2xx_udc.h               |    5 ++-
 .../linux/platform_data/sa11x0-serial.h            |    6 ++-
 22 files changed, 24 insertions(+), 107 deletions(-)
 delete mode 100644 arch/arm/include/asm/mach/serial_at91.h
 delete mode 100644 arch/avr32/include/asm/mach/serial_at91.h
 rename arch/arm/include/asm/mach/udc_pxa2xx.h => include/linux/platform_data/pxa2xx_udc.h (94%)
 rename arch/arm/include/asm/mach/serial_sa1100.h => include/linux/platform_data/sa11x0-serial.h (93%)
