From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Tue,  2 Sep 2014 14:19:05 -0700
Subject: [PATCH v2 0/9] Zynq PM updates
Message-ID: <1409692754-13437-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

here is v2 of this series. It's mostly the same and most changes are
related to reformatting comments. The only functional change is in 'ARM:
zynq: PM: Enable DDR clock stop' which does no longer enable
self-refresh too. It seems self-refresh is inflicting a non-negligible
amount of latency that degrades memory performance if enabled throughout
the whole run time.

	Thanks,
	S?ren

Daniel Lezcano (2):
  ARM: zynq: Remove invalidate cache for cpu die
  ARM: zynq: cpuidle: Remove pointless code

Soren Brinkmann (7):
  ARM: zynq: PM: Enable A9 internal clock gating feature
  Documentation: devicetree: Add binding for Synopsys DDR controller
  ARM: zynq: DT: Add DDRC node
  ARM: zynq: PM: Enable DDR clock stop
  ARM: zynq: Synchronise zynq_cpu_die/kill
  ARM: zynq: Remove hotplug.c
  ARM: zynq: Rename 'zynq_platform_cpu_die'

 .../bindings/memory-controllers/synopsys.txt       | 11 +++
 arch/arm/boot/dts/zynq-7000.dtsi                   |  5 ++
 arch/arm/mach-zynq/Makefile                        |  3 +-
 arch/arm/mach-zynq/common.c                        |  7 ++
 arch/arm/mach-zynq/common.h                        | 16 ++++-
 arch/arm/mach-zynq/hotplug.c                       | 47 +-----------
 arch/arm/mach-zynq/platsmp.c                       | 41 ++++++++++-
 arch/arm/mach-zynq/pm.c                            | 83 ++++++++++++++++++++++
 arch/arm/mach-zynq/slcr.c                          | 43 ++++++++++-
 drivers/cpuidle/cpuidle-zynq.c                     | 10 +--
 10 files changed, 205 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys.txt
 create mode 100644 arch/arm/mach-zynq/pm.c

-- 
2.1.0.1.g27b9230
