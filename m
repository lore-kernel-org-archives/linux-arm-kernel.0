From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 13 Jul 2012 17:19:30 -0500
Subject: [RFC 0/4] ARM: OMAP3+: Add device-tree support for timers
Message-ID: <1342217976-29802-1-git-send-email-jon-hunter@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series adds device-tree support for the timers on OMAP3/4 devices. Once
everyone is happy with the implementation I can add support for OMAP2/5 devices
too.

Testing:
- I have tested the all the timers (not used by the kernel as sys-timers) on
  both OMAP3430 Beagle and OMAP4460 Panda with/without device-tree with this
  series.
- The testing includes
	- Configuring, starting a timer and checking the counter value is
	  incrementing.
	- Testing timer overflow interrupt when timer expires.
	- Using different clock sources to operate the timer with.
	- Using DT to provide resource information for IRQ and memory by
	  removing Benoit's intention "HACK" in commit a4f6cdb0 (ARM: OMAP:
	  omap_device: Add omap_device_[alloc|delete] for DT integration)

Jon Hunter (4):
  arm/dts: OMAP: Add timer nodes
  ARM: OMAP3: Dynamically disable secure timer nodes for secure devices
  ARM: OMAP4: Add timer clock aliases for device-tree
  ARM: OMAP: Add DT support for timer driver

 .../devicetree/bindings/arm/omap/timer.txt         |   34 +++++++
 arch/arm/boot/dts/omap3.dtsi                       |  104 ++++++++++++++++++++
 arch/arm/boot/dts/omap4.dtsi                       |   93 +++++++++++++++++
 arch/arm/mach-omap2/board-generic.c                |    1 +
 arch/arm/mach-omap2/clock44xx_data.c               |   12 +++
 arch/arm/mach-omap2/common.h                       |    1 +
 arch/arm/mach-omap2/timer.c                        |   40 ++++++++
 arch/arm/plat-omap/dmtimer.c                       |   32 ++++--
 8 files changed, 311 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/omap/timer.txt

-- 
1.7.9.5
