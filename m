From: jamie@jamieiles.com (Jamie Iles)
Date: Tue,  9 Aug 2011 11:10:58 +0100
Subject: [PATCH 0/3] Device Tree support for Picochip picoXcell
Message-ID: <1312884661-27205-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds initial support for Picochip picoXcell devices.  I've based
this off of Grant's devicetree/test branch and also on top of Russell's GPIO
includes cleanup.

I have a second set of patches that add clk support but I've left them out for
now to keep the changes to a minimum.

Jamie Iles (3):
  picoxcell: support for Picochip picoxcell devices
  picoxcell: add the DTS for pc3x2 and pc3x3 devices
  picoxcell: add the DTS for the PC7302 board

 .../devicetree/bindings/arm/picoxcell.txt          |   27 ++
 arch/arm/Kconfig                                   |   18 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi             |  232 +++++++++++++
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi             |  344 ++++++++++++++++++++
 arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts       |   87 +++++
 arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts       |   93 ++++++
 arch/arm/mach-picoxcell/Makefile                   |    3 +
 arch/arm/mach-picoxcell/Makefile.boot              |    1 +
 arch/arm/mach-picoxcell/common.c                   |   72 ++++
 arch/arm/mach-picoxcell/common.h                   |   18 +
 arch/arm/mach-picoxcell/include/mach/debug-macro.S |   35 ++
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   19 +
 arch/arm/mach-picoxcell/include/mach/gpio.h        |   17 +
 arch/arm/mach-picoxcell/include/mach/hardware.h    |   21 ++
 arch/arm/mach-picoxcell/include/mach/io.h          |   30 ++
 arch/arm/mach-picoxcell/include/mach/irqs.h        |   25 ++
 arch/arm/mach-picoxcell/include/mach/map.h         |   25 ++
 arch/arm/mach-picoxcell/include/mach/memory.h      |   17 +
 .../mach-picoxcell/include/mach/picoxcell_soc.h    |   25 ++
 arch/arm/mach-picoxcell/include/mach/system.h      |   31 ++
 arch/arm/mach-picoxcell/include/mach/timex.h       |   25 ++
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   60 ++++
 arch/arm/mach-picoxcell/include/mach/vmalloc.h     |   18 +
 arch/arm/mach-picoxcell/io.c                       |   56 ++++
 arch/arm/mach-picoxcell/time.c                     |  132 ++++++++
 26 files changed, 1432 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/picoxcell.txt
 create mode 100644 arch/arm/boot/dts/picoxcell-pc3x2.dtsi
 create mode 100644 arch/arm/boot/dts/picoxcell-pc3x3.dtsi
 create mode 100644 arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts
 create mode 100644 arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts
 create mode 100644 arch/arm/mach-picoxcell/Makefile
 create mode 100644 arch/arm/mach-picoxcell/Makefile.boot
 create mode 100644 arch/arm/mach-picoxcell/common.c
 create mode 100644 arch/arm/mach-picoxcell/common.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/debug-macro.S
 create mode 100644 arch/arm/mach-picoxcell/include/mach/entry-macro.S
 create mode 100644 arch/arm/mach-picoxcell/include/mach/gpio.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/hardware.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/io.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/irqs.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/map.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/memory.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/picoxcell_soc.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/system.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/timex.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/uncompress.h
 create mode 100644 arch/arm/mach-picoxcell/include/mach/vmalloc.h
 create mode 100644 arch/arm/mach-picoxcell/io.c
 create mode 100644 arch/arm/mach-picoxcell/time.c

-- 
1.7.4.1
