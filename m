From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 19 Nov 2014 11:49:54 +0000
Subject: [PATCH 0/6] arm: specify PMU type in platform data
Message-ID: <1416397800-12457-1-git-send-email-mark.rutland@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently the ARMv6, ARMv7, and XScale PMU drivers are coupled with each
other, and all included in the same c file. To enable the splitting of
the ARMv6, ARMv7, and XScale PMU drivers, and the conversion of the
arm_pmu framework to a pure library, we need to be a be more precise
when describing PMUs, to enable association of the PMU with the right
driver. In device tree this is already implicit in the compatible
string, but platform data currently only specifies "arm-pmu".

Commit 253d8c3d2518ca6f (arm: perf: add more specific platform device
IDs) added "armv6-pmu", "armv7-pmu", and "xscale-pmu" platform device
IDs, enabling the three to be distinguished. This series updates
platform code to use these strings.

A later patch series will decouple the drivers.

Thanks,
Mark.

Mark Rutland (6):
  arm: realview: specify PMU types
  arm: pxa: specify PMUs are for XScale CPUs
  arm: vexpress: specify PMUs are for ARMv7 CPUs
  arm: iop: specify PMUs are for XScale CPUs
  arm: shmobile: specify PMUs are for ARMv7 CPUs
  arm: omap: specify PMUs are for ARMv7 CPUs

 arch/arm/mach-omap2/pmu.c                | 5 +++--
 arch/arm/mach-pxa/devices.c              | 2 +-
 arch/arm/mach-realview/realview_eb.c     | 3 ++-
 arch/arm/mach-realview/realview_pb1176.c | 2 +-
 arch/arm/mach-realview/realview_pb11mp.c | 2 +-
 arch/arm/mach-realview/realview_pba8.c   | 2 +-
 arch/arm/mach-realview/realview_pbx.c    | 2 +-
 arch/arm/mach-shmobile/setup-r8a7740.c   | 2 +-
 arch/arm/mach-shmobile/setup-sh73a0.c    | 2 +-
 arch/arm/mach-vexpress/ct-ca9x4.c        | 2 +-
 arch/arm/plat-iop/pmu.c                  | 2 +-
 11 files changed, 14 insertions(+), 12 deletions(-)

-- 
1.9.1
