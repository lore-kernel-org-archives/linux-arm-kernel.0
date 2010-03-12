From: will.deacon@arm.com (Will Deacon)
Date: Fri, 12 Mar 2010 17:29:38 +0000
Subject: [RFC PATCH 0/6] ARM: pmu: provide a registration mechanism for IRQs
	[v2]
Message-ID: <1268414985-22699-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is version 2 of the patch series originally posted here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2010-March/011162.html

Changes from the original version include:

- Removal of const keyword from IRQs to make it easier to select
  the IRQs to register at runtime.
- Support for all the relevant Realview boards
- Support for OMAP2, OMAP3, BCMRING, iop and PXA platforms

The main reason for submitting this is to get some feedback on the
registration code I've added to the board files because I'm not familiar
with how the omap / bcmring / pxa / iop trees are structured.

All feedback welcome [including the results of any testing for the
platforms I've mentioned].

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

 arch/arm/include/asm/pmu.h               |   36 ++++++++---
 arch/arm/kernel/perf_event.c             |    6 +-
 arch/arm/kernel/pmu.c                    |  103 ++++++++++++++++-------------
 arch/arm/mach-bcmring/arch.c             |   13 ++++
 arch/arm/mach-omap2/devices.c            |   30 +++++++++
 arch/arm/mach-pxa/pxa25x.c               |   14 ++++
 arch/arm/mach-pxa/pxa27x.c               |   13 ++++
 arch/arm/mach-pxa/pxa3xx.c               |   14 ++++
 arch/arm/mach-realview/realview_eb.c     |   15 ++++
 arch/arm/mach-realview/realview_pb1176.c |   12 ++++
 arch/arm/mach-realview/realview_pb11mp.c |   15 ++++
 arch/arm/mach-realview/realview_pba8.c   |   12 ++++
 arch/arm/mach-realview/realview_pbx.c    |   15 ++++
 arch/arm/plat-iop/Makefile               |    2 +
 arch/arm/plat-iop/pmu.c                  |   37 +++++++++++
 15 files changed, 278 insertions(+), 59 deletions(-)
 create mode 100644 arch/arm/plat-iop/pmu.c
