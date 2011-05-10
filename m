From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 10 May 2011 08:27:00 +0100
Subject: [PATCH 00/13] Consolidate simple ARM MMIO clock sources
Message-ID: <20110510072700.GA29869@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In a similar light to the i8253 series, this consolidates 17 ARM
MMIO counter clocksources into a single common implementation.  This
common implementation caters for 32-bit and 16-bit register access
sizes, up and down counters, and various bit sizes of those counters.

Patch 1 is already in John Stultz tree, but is included for
completeness and to get rid of a build warning.

 arch/arm/Kconfig                         |   14 ++++++
 arch/arm/common/timer-sp.c               |   22 +--------
 arch/arm/mach-integrator/Kconfig         |    1 +
 arch/arm/mach-integrator/integrator_ap.c |   21 +-------
 arch/arm/mach-ixp4xx/common.c            |   16 +------
 arch/arm/mach-lpc32xx/timer.c            |   17 +------
 arch/arm/mach-mxs/timer.c                |   20 +++-----
 arch/arm/mach-netx/time.c                |   16 +------
 arch/arm/mach-omap1/time.c               |   69 +++++++++-------------------
 arch/arm/mach-pxa/time.c                 |   17 +------
 arch/arm/mach-sa1100/time.c              |   24 ++--------
 arch/arm/mach-tcc8k/time.c               |   16 +------
 arch/arm/mach-tegra/timer.c              |   16 +------
 arch/arm/mach-u300/timer.c               |   18 +------
 arch/arm/mach-w90x900/time.c             |   17 +------
 arch/arm/plat-mxc/epit.c                 |   18 +-------
 arch/arm/plat-mxc/time.c                 |   38 +++-------------
 arch/arm/plat-nomadik/Kconfig            |    1 +
 arch/arm/plat-nomadik/timer.c            |   31 +------------
 arch/arm/plat-omap/Kconfig               |    1 +
 arch/arm/plat-orion/time.c               |   21 +--------
 arch/arm/plat-s5p/s5p-time.c             |   58 +++++++-----------------
 arch/arm/plat-spear/time.c               |   16 +------
 drivers/Kconfig                          |    3 +
 drivers/clocksource/Kconfig              |    2 +
 drivers/clocksource/Makefile             |    1 +
 drivers/clocksource/mmio.c               |   72 ++++++++++++++++++++++++++++++
 include/linux/clocksource.h              |   10 ++++-
 28 files changed, 194 insertions(+), 382 deletions(-)
