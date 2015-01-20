From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 20 Jan 2015 16:07:24 +0000
Subject: [PATCHv2 0/5] arm: specify PMU type in platform data
Message-ID: <1421770049-32029-1-git-send-email-mark.rutland@arm.com>
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

Since v1 [1]:
* Rebase to v3.19-rc4.
* Add Acks.
* Drop vexpress patches (platform code deleted).

Simon, in v1 you mentioned you were happy to take the shmobile patch
through your tree. Are you still happy to do so, or to give your ack
such that these can go through arm-soc together?

While I'm not too concerned which route these patches take, it would be
nice to have a single base for the patches splitting the drivers.

Thanks,
Mark.

[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2014-November/304078.html

Mark Rutland (5):
  arm: realview: specify PMU types
  arm: pxa: specify PMUs are for XScale CPUs
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
 arch/arm/plat-iop/pmu.c                  | 2 +-
 10 files changed, 13 insertions(+), 11 deletions(-)

-- 
1.9.1
