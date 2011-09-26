From: jamie@jamieiles.com (Jamie Iles)
Date: Mon, 26 Sep 2011 16:24:45 +0100
Subject: [PATCHv3 0/4] Initial support for Picochip picoXcell
Message-ID: <1317050689-16417-1-git-send-email-jamie@jamieiles.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is largely a repost of v2, but with a couple of minor changes:
	- Removed bootargs from board dts files
	- Fix up the VIC binding documentation

I've also added a 4th patch which removes the picoxcell specific ioremap
functionality.  This could either be applied/folded into the first patch
if Nicolas' vmalloc cleanups go in.

These patches can also be found in a git tree at:

	git://github.com/jamieiles/linux-2.6-ji.git for-next

Jamie Iles (4):
  picoxcell: support for Picochip picoxcell devices
  picoxcell: add the DTS for pc3x2 and pc3x3 devices
  picoxcell: add the DTS for the PC7302 board
  picoxcell: remove custom ioremap implementation

 .../devicetree/bindings/arm/picoxcell.txt          |   24 ++
 arch/arm/Kconfig                                   |   18 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/picoxcell-pc3x2.dtsi             |  249 +++++++++++++
 arch/arm/boot/dts/picoxcell-pc3x3.dtsi             |  365 ++++++++++++++++++++
 arch/arm/boot/dts/picoxcell-pc7302-pc3x2.dts       |   86 +++++
 arch/arm/boot/dts/picoxcell-pc7302-pc3x3.dts       |   92 +++++
 arch/arm/mach-picoxcell/Makefile                   |    3 +
 arch/arm/mach-picoxcell/Makefile.boot              |    1 +
 arch/arm/mach-picoxcell/common.c                   |   55 +++
 arch/arm/mach-picoxcell/common.h                   |   18 +
 arch/arm/mach-picoxcell/include/mach/debug-macro.S |   35 ++
 arch/arm/mach-picoxcell/include/mach/entry-macro.S |   19 +
 arch/arm/mach-picoxcell/include/mach/gpio.h        |    1 +
 arch/arm/mach-picoxcell/include/mach/hardware.h    |   21 ++
 arch/arm/mach-picoxcell/include/mach/io.h          |   22 ++
 arch/arm/mach-picoxcell/include/mach/irqs.h        |   25 ++
 arch/arm/mach-picoxcell/include/mach/map.h         |   25 ++
 arch/arm/mach-picoxcell/include/mach/memory.h      |    1 +
 .../mach-picoxcell/include/mach/picoxcell_soc.h    |   25 ++
 arch/arm/mach-picoxcell/include/mach/system.h      |   31 ++
 arch/arm/mach-picoxcell/include/mach/timex.h       |   25 ++
 arch/arm/mach-picoxcell/include/mach/uncompress.h  |   21 ++
 arch/arm/mach-picoxcell/io.c                       |   32 ++
 arch/arm/mach-picoxcell/time.c                     |  132 +++++++
 25 files changed, 1327 insertions(+), 0 deletions(-)
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
 create mode 100644 arch/arm/mach-picoxcell/io.c
 create mode 100644 arch/arm/mach-picoxcell/time.c

-- 
1.7.4.1
