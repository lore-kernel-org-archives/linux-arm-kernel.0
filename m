From: will.deacon@arm.com (Will Deacon)
Date: Thu, 25 Mar 2010 15:16:32 +0000
Subject: [PATCH 0/6] ARM: pmu: provide a registration mechanism for IRQs [v3]
Message-ID: <1269530198-19572-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 3 of the patch series originally posted here:

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011162.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011339.html

Changes from version 2 include:

- PXA PMU registration moved out of mach-pxa and into plat-pxa
- Use of a platform_device to represent the PMU
- Fixes in pmu.c in response to comments from Jamie Iles
- Taken against 2.6.34-rc2

I'd like to submit this to the patch system soon, so please let me
know if the mach-* and plat-* changes require any further work.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Jamie Iles <jamie.iles@picochip.com>
Cc: Tony Lindgren <tony@atomide.com>
Cc: Leo Chen <leochen@broadcom.com>
Cc: Lennert Buytenhek <kernel@wantstofly.org>
Cc: Eric Miao <eric.y.miao@gmail.com>


Will Deacon (6):
  ARM: pmu: register IRQs at runtime
  ARM: Realview: register PMU IRQs during board initialisation
  ARM: OMAP: register PMU IRQs during board initialisation
  ARM: BCMRING: register PMU IRQ during board initialisation
  ARM: iop3xx: register PMU IRQs during board initialisation
  ARM: pxa: register PMU IRQs during board initialisation

 arch/arm/include/asm/pmu.h               |   32 ++++----
 arch/arm/kernel/perf_event.c             |   36 +++++----
 arch/arm/kernel/pmu.c                    |  127 +++++++++++++++++++----------
 arch/arm/mach-bcmring/arch.c             |   16 ++++
 arch/arm/mach-omap2/devices.c            |   34 ++++++++
 arch/arm/mach-realview/realview_eb.c     |   32 ++++++++
 arch/arm/mach-realview/realview_pb1176.c |   15 ++++
 arch/arm/mach-realview/realview_pb11mp.c |   32 ++++++++
 arch/arm/mach-realview/realview_pba8.c   |   15 ++++
 arch/arm/mach-realview/realview_pbx.c    |   32 ++++++++
 arch/arm/plat-iop/Makefile               |    2 +
 arch/arm/plat-iop/pmu.c                  |   40 +++++++++
 arch/arm/plat-pxa/Makefile               |    2 +-
 arch/arm/plat-pxa/pmu.c                  |   33 ++++++++
 14 files changed, 371 insertions(+), 77 deletions(-)
 create mode 100644 arch/arm/plat-iop/pmu.c
 create mode 100644 arch/arm/plat-pxa/pmu.c
