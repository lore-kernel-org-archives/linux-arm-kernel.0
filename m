From: jamie@jamieiles.com (Jamie Iles)
Date: Fri, 18 Feb 2011 10:00:27 +0000
Subject: [PATCHv5 0/4] ARM: add initial support for Picochip picoXcell SoC
Message-ID: <1298023231-2747-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This patch series adds support for the Picochip picoXcell series of
femtocell SoC's. There are currently two device families - PC3X2 and
PC3X3. Both include an ARM1176JZ-S, 100Mb Ethernet controller, 2xDMA
controllers, eFuses, crypto offload engines and Picochip's array
processor the picoArray. 

I've reduced this patch series down pretty much to the bare minimum to
boot on all device families with serial access but not much more.
Hopefully this will make this series a little easier to review and we
can add the GPIO, muxing, clock gating and PM etc once these have been
merged.

Any feedback would be much appreciated!

Jamie

Note: we also need this patch for the CONFIG_DEBUG_LL:

    - debug-8250: add a 32 bit mode:
    http://marc.info/?l=linux-arm-kernel&m=129044061221371&w=2

Jamie Iles (4):
  picoxcell: add support for picoXcell
  picoxcell: add support for the system timers
  picoxcell: add common SoC devices
  picoxcell: add support for the PC7302 development board

 arch/arm/Kconfig                                   |   13 ++
 arch/arm/Makefile                                  |    1 +
 arch/arm/mach-picoxcell/Kconfig                    |   12 +
 arch/arm/mach-picoxcell/Makefile                   |    4 +
 arch/arm/mach-picoxcell/Makefile.boot              |    3 +
 arch/arm/mach-picoxcell/axi2cfg.c                  |   36 ++++
 arch/arm/mach-picoxcell/board_pc7302.c             |  109 ++++++++++
 arch/arm/mach-picoxcell/devices.c                  |  122 +++++++++++
 arch/arm/mach-picoxcell/include/mach/debug-macro.S |   18 ++
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   19 ++
 arch/arm/mach-picoxcell/include/mach/hardware.h    |   29 +++
 arch/arm/mach-picoxcell/include/mach/io.h          |   38 ++++
 arch/arm/mach-picoxcell/include/mach/irqs.h        |   89 ++++++++
 arch/arm/mach-picoxcell/include/mach/memory.h      |   27 +++
 .../include/mach/picoxcell/axi2cfg.h               |  122 +++++++++++
 .../mach-picoxcell/include/mach/picoxcell/gpio.h   |   48 +++++
 .../include/mach/picoxcell/picoxcell.h             |   62 ++++++
 .../mach-picoxcell/include/mach/picoxcell/timer.h  |   37 ++++
 .../mach-picoxcell/include/mach/picoxcell/wdog.h   |   43 ++++
 arch/arm/mach-picoxcell/include/mach/platform.h    |   27 +++
 arch/arm/mach-picoxcell/include/mach/system.h      |   51 +++++
 arch/arm/mach-picoxcell/include/mach/timex.h       |   26 +++
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   60 ++++++
 arch/arm/mach-picoxcell/include/mach/vmalloc.h     |   18 ++
 arch/arm/mach-picoxcell/io.c                       |   49 +++++
 arch/arm/mach-picoxcell/picoxcell_core.c           |  106 ++++++++++
 arch/arm/mach-picoxcell/picoxcell_core.h           |   25 +++
 arch/arm/mach-picoxcell/soc.h                      |   32 +++
 arch/arm/mach-picoxcell/time.c                     |  222 ++++++++++++++++++++
 29 files changed, 1448 insertions(+), 0 deletions(-)
 create mode 100644 arch/arm/mach-picoxcell/Kconfig
 create mode 100644 arch/arm/mach-picoxcell/Makefile
 create mode 100644 arch/arm/mach-picoxcell/Makefile.boot
 create mode 100644 arch/arm/mach-picoxcell/axi2cfg.c
 create mode 100644 arch/arm/mach-picoxcell/board_pc7302.c
 create mode 100644 arch/arm/mach-picoxcell/devices.c
 create mode 100644 arch/arm/mach-picoxcell/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-picoxcell/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-picoxcell/include/mach/hardware.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/io.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/irqs.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/memory.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/axi2cfg.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/gpio.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/picoxcell.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/timer.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell/wdog.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/platform.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/system.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/timex.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-picoxcell/io.c
 create mode 100644 arch/arm/mach-picoxcell/picoxcell_core.c
 create mode 100644 arch/arm/mach-picoxcell/picoxcell_core.h
 create mode 100644 arch/arm/mach-picoxcell/soc.h
 create mode 100644 arch/arm/mach-picoxcell/time.c

-- 
1.7.4
