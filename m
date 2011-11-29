From: pawel.moll@arm.com (Pawel Moll)
Date: Tue, 29 Nov 2011 15:11:08 +0000
Subject: [PATCH v3 0/5] Versatile Express DT support
Message-ID: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

Another, hopefully close to the final, version of the series...

Changes from v2:

* new patch adding ENDPROC at the end of arch/arm/plat-versatile/headsmp.S
  and removing use of BSYM() realview and vexpress platform SMP calls

* updated binding documentation according to Dave's comments

* changed motherboard labels prefix from mb_ to v2m_ (to be
  consistent across code and DT files)

* reworked v2m timer initialization (again) so no #ifdefs are required
  in non-DT code

* renamed (to vendor- and platform-specific "arm,v2m-timer") and moved
  (to vexpress-v2m*.dtsi files) timer DT alias, as it is actually
  motherboard specific and the tile DTS shouldn't have to care;
  documentation updated accordingly

Tested on V2P-CA9 with ATAGs and DT and on V2P-CA5s with DT.

Previous version has been also tested by Ryan Harkin and
provisionally acked by Rob Herring.

Thanks for all your help, especially to Dave for his continuous support!

Pawel Moll (5):
  ARM: versatile: Add missing ENDPROC to headsmp.S
  ARM: vexpress: Get rid of MMIO_P2V
  ARM: vexpress: Add DT support in v2m
  ARM: vexpress: Initial RS1 memory map support
  ARM: vexpress: DT-based support for CoreTiles Express A5x2 and A9x4

 Documentation/devicetree/bindings/arm/vexpress.txt |  108 +++++++++
 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi            |  196 +++++++++++++++
 arch/arm/boot/dts/vexpress-v2m.dtsi                |  195 +++++++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts            |  131 ++++++++++
 arch/arm/boot/dts/vexpress-v2p-ca9.dts             |  145 +++++++++++
 arch/arm/include/asm/hardware/arm_timer.h          |    5 +
 arch/arm/mach-realview/platsmp.c                   |    3 +-
 arch/arm/mach-vexpress/Kconfig                     |   37 +++
 arch/arm/mach-vexpress/Makefile                    |    1 +
 arch/arm/mach-vexpress/Makefile.boot               |    6 +
 arch/arm/mach-vexpress/core.h                      |   21 ++-
 arch/arm/mach-vexpress/ct-ca9x4.c                  |   52 +---
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h     |   13 +-
 arch/arm/mach-vexpress/include/mach/debug-macro.S  |   37 +++-
 arch/arm/mach-vexpress/include/mach/motherboard.h  |   58 +++--
 arch/arm/mach-vexpress/include/mach/uncompress.h   |   13 +-
 arch/arm/mach-vexpress/platsmp.c                   |    7 +-
 arch/arm/mach-vexpress/v2m.c                       |  255 ++++++++++++++++++--
 arch/arm/mach-vexpress/v2p-ca5s_ca9.c              |  115 +++++++++
 arch/arm/plat-versatile/headsmp.S                  |    1 +
 20 files changed, 1286 insertions(+), 113 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/vexpress.txt
 create mode 100644 arch/arm/boot/dts/vexpress-v2m-rs1.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2m.dtsi
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca5s.dts
 create mode 100644 arch/arm/boot/dts/vexpress-v2p-ca9.dts
 create mode 100644 arch/arm/mach-vexpress/v2p-ca5s_ca9.c
