From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 24 Aug 2011 15:41:43 +0100
Subject: [PATCHv2 0/3] Initial support for Picochip picoxcell
Message-ID: <1314196906-20709-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds support for Picochip picoXcell (PC3X2 and PC3X3)
ARM1176JZ-S based devices.  This is a device tree only platform and
currently supports interrupt controllers and UARTs.

This series is based off of Grant's devicetree/test branch and also uses
Russell's io and gpio cleanup patches to remove the definition of
IO_SPACE_LIMIT and trivial gpio definitions.

Changes since v1:

	- Cleanup empty headers
	- Use of_platform_populate() and the default match table
	- Split the VIC's into separate device nodes

Jamie Iles (3):
  picoxcell: support for Picochip picoxcell devices
  picoxcell: add the DTS for pc3x2 and pc3x3 devices
  picoxcell: add the DTS for the PC7302 board

 .../devicetree/bindings/arm/picoxcell.txt          |   23 ++
 arch/arm/Kconfig                                   |   18 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi             |  249 +++++++++++++
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi             |  365 ++++++++++++++++++++
 arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts       |   87 +++++
 arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts       |   93 +++++
 arch/arm/mach-picoxcell/Makefile                   |    3 +
 arch/arm/mach-picoxcell/Makefile.boot              |    1 +
 arch/arm/mach-picoxcell/common.c                   |   55 +++
 arch/arm/mach-picoxcell/common.h                   |   18 +
 arch/arm/mach-picoxcell/include/mach/debug-macro.S |   35 ++
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   19 +
 arch/arm/mach-picoxcell/include/mach/gpio.h        |    1 +
 arch/arm/mach-picoxcell/include/mach/hardware.h    |   21 ++
 arch/arm/mach-picoxcell/include/mach/io.h          |   29 ++
 arch/arm/mach-picoxcell/include/mach/irqs.h        |   25 ++
 arch/arm/mach-picoxcell/include/mach/map.h         |   25 ++
 arch/arm/mach-picoxcell/include/mach/memory.h      |    1 +
 .../mach-picoxcell/include/mach/picoxcell_soc.h    |   25 ++
 arch/arm/mach-picoxcell/include/mach/system.h      |   31 ++
 arch/arm/mach-picoxcell/include/mach/timex.h       |   25 ++
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   21 ++
 arch/arm/mach-picoxcell/include/mach/vmalloc.h     |   18 +
 arch/arm/mach-picoxcell/io.c                       |   56 +++
 arch/arm/mach-picoxcell/time.c                     |  132 +++++++
 26 files changed, 1377 insertions(+), 0 deletions(-)
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
