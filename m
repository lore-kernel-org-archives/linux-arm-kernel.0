From: pawel.moll@arm.com (Pawel Moll)
Date: Fri, 11 Nov 2011 18:27:01 +0000
Subject: [PATCH 0/5] Versatile Express DT support, take 2
Message-ID: <1321036026-23411-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello again,

I've manage to clean up the VE DT patches.

Changes since RFC:

* I think I did all the changes suggested by Rob (including
  using "custom" clock lookups instead of auxdata - do
  comment, please ;-)

* Merged CA5s and CA9 code into one file.

* Added documentation for the vexpress bindings.

* Reorganized the tree so the "flat aliases search" patch
  is not longer necessary.

* Moved the alias node from motherboard's to tile's DTS,
  as this is the place to decide about serial port ordering,
  timers being used etc.

* Got the SMSC working (my fault, obviously ;-)

As usual - feedback more than welcome (my tests suggest
that the "ATAG version" still works, so feel free to test
at least that ;-)

Cheers!

Pawel



Pawel Moll (5):
  ARM: vexpress: Get rid of MMIO_P2V
  ARM: vexpress: Remove platform SMP functions from ct_desc
  ARM: vexpress: Add DT support in v2m
  ARM: vexpress: Initial RS1 memory map support
  ARM: vexpress: DT-based support for CoreTiles Express A5x2 and A9x4

 Documentation/devicetree/bindings/arm/vexpress    |   92 ++++++++
 arch/arm/boot/dts/vexpress-v2m-legacy.dtsi        |  190 ++++++++++++++++
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi           |  190 ++++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts           |  132 +++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts            |  146 ++++++++++++
 arch/arm/include/asm/hardware/arm_timer.h         |    5 +
 arch/arm/mach-vexpress/Kconfig                    |   28 +++
 arch/arm/mach-vexpress/Makefile                   |    1 +
 arch/arm/mach-vexpress/Makefile.boot              |    6 +-
 arch/arm/mach-vexpress/core.h                     |   27 ++-
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   96 +++------
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h    |   13 +-
 arch/arm/mach-vexpress/include/mach/debug-macro.S |   37 +++-
 arch/arm/mach-vexpress/include/mach/motherboard.h |   65 +++---
 arch/arm/mach-vexpress/include/mach/uncompress.h  |   13 +-
 arch/arm/mach-vexpress/platsmp.c                  |   11 +-
 arch/arm/mach-vexpress/v2m.c                      |  250 +++++++++++++++++++--
 arch/arm/mach-vexpress/v2p-ca5s_ca9.c             |  103 +++++++++
 18 files changed, 1263 insertions(+), 142 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-legacy.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca5s.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts
 create mode 100644 arch/arm/mach-vexpress/v2p-ca5s_ca9.c
