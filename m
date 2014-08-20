From: soren.brinkmann@xilinx.com (Soren Brinkmann)
Date: Wed, 20 Aug 2014 13:41:46 -0700
Subject: [PATCH 0/9] Zynq PM updates
Message-ID: <1408567315-28479-1-git-send-email-soren.brinkmann@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I'm working on some PM-related updates and suspend for Zynq (for the
interested, a branch with all patches is found here:
https://github.com/sorenb-xlnx/linux-xlnx/commits/suspend).

This series consists of the rather unproblematic parts that affect Zynq
only and have no further dependencies. It's a little bit of clean up
(thanks to Daniel too) and enabling a couple of the HW's power saving
features.

	Thanks,
	S?ren

Daniel Lezcano (2):
  ARM: zynq: Remove invalidate cache for cpu die
  ARM: zynq: cpuidle: Remove pointless code

Soren Brinkmann (7):
  ARM: zynq: PM: Enable A9 internal clock gating feature
  Documentation: devicetree: Add binding for Synopsys DDR controller
  ARM: zynq: DT: Add DDRC node
  ARM: zynq: PM: Enable DDR self-refresh and clock stop
  ARM: zynq: Synchronise zynq_cpu_die/kill
  ARM: zynq: Remove hotplug.c
  ARM: zynq: Rename 'zynq_platform_cpu_die'

 .../bindings/memory-controllers/synopsys.txt       | 11 +++
 arch/arm/boot/dts/zynq-7000.dtsi                   |  5 ++
 arch/arm/mach-zynq/Makefile                        |  3 +-
 arch/arm/mach-zynq/common.c                        |  7 ++
 arch/arm/mach-zynq/common.h                        | 18 ++++-
 arch/arm/mach-zynq/hotplug.c                       | 47 +-----------
 arch/arm/mach-zynq/platsmp.c                       | 35 ++++++++-
 arch/arm/mach-zynq/pm.c                            | 84 ++++++++++++++++++++++
 arch/arm/mach-zynq/slcr.c                          | 43 ++++++++++-
 drivers/cpuidle/cpuidle-zynq.c                     | 10 +--
 10 files changed, 202 insertions(+), 61 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/synopsys.txt
 create mode 100644 arch/arm/mach-zynq/pm.c

-- 
2.0.1.1.gfbfc394
