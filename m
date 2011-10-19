From: zdevai@gmail.com (Zoltan Devai)
Date: Wed, 19 Oct 2011 22:29:01 +0200
Subject: [PATCH v2 0/5] ARM: Add support for the SPMP8000 SoC and Letcool
	board v2
Message-ID: <CAGVye5NitpMGxs2QiPm_YWSMqUTzN+obgcuXSTvCj6nSk=A34g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry if you get this multiple times, the original cover letter was held for
moderation, and I don't know whether I succeeded in canceling it.

Hi,

This series adds support for the Sunplus SPMP8000 SoC, an ARM926EJ-S based
MCU, which is most commonly found in handheld game consoles and digital cams.
Most of the work was done during GSoC 2011, with Greg KH as my mentor.

The board I'm using for development is the Letcool N350JP handheld.

The patches are based on Arnds for-next branch with Jamie Iles' vic-dt patches
on top and cherry-picks from Russells for-next : trivial GPIOLIB,
common clk_lookup macro, default IO_SPACE_LIMIT.
(If anyone has a suggestion on what single branch to base this on, please help)

Changes since v1:
- removed all definitions, headers, dts descriptions for drivers and devices
  without DT bindings
- removed Letcool board file
- removed static mappings of clock controllers
- removed IO_SPACE_LIMIT, PLAT_PHYS_OFFSET definitions and GPIO accelerators
- fixed clock clode, removed local-variable-referencing macros, and random bits
- lluart is now in a separate file
- timer driver moved to drivers/clocksource

Thanks to all the reviewers so far!

Cheers,
Zoltan

 Documentation/devicetree/bindings/arm/spmp8000.txt |   25 +
 arch/arm/Kconfig                                   |   16 +
 arch/arm/Makefile                                  |    1 +
 arch/arm/boot/dts/spmp8000-letcool.dts             |   20 +
 arch/arm/boot/dts/spmp8000.dtsi                    |   93 +++
 arch/arm/mach-spmp8000/Makefile                    |    4 +
 arch/arm/mach-spmp8000/Makefile.boot               |    1 +
 arch/arm/mach-spmp8000/clkdev.c                    |  611 ++++++++++++++++++++
 arch/arm/mach-spmp8000/clock.c                     |  149 +++++
 arch/arm/mach-spmp8000/clock.h                     |   32 +
 arch/arm/mach-spmp8000/core.c                      |   79 +++
 arch/arm/mach-spmp8000/core.h                      |   27 +
 arch/arm/mach-spmp8000/include/mach/debug-macro.S  |   19 +
 arch/arm/mach-spmp8000/include/mach/entry-macro.S  |   14 +
 arch/arm/mach-spmp8000/include/mach/gpio.h         |    1 +
 arch/arm/mach-spmp8000/include/mach/hardware.h     |   25 +
 arch/arm/mach-spmp8000/include/mach/io.h           |   17 +
 arch/arm/mach-spmp8000/include/mach/irqs.h         |   21 +
 arch/arm/mach-spmp8000/include/mach/memory.h       |    1 +
 arch/arm/mach-spmp8000/include/mach/system.h       |   43 ++
 arch/arm/mach-spmp8000/include/mach/timex.h        |   17 +
 arch/arm/mach-spmp8000/include/mach/uncompress.h   |   37 ++
 arch/arm/mach-spmp8000/include/mach/vmalloc.h      |   16 +
 arch/arm/mach-spmp8000/lluart.c                    |   24 +
 drivers/clocksource/Makefile                       |    3 +-
 drivers/clocksource/spmp8000_tmrb.c                |  159 +++++
 26 files changed, 1454 insertions(+), 1 deletions(-)
