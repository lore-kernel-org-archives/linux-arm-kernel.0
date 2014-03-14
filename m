From: matthew.leach@arm.com (Matthew Leach)
Date: Fri, 14 Mar 2014 10:18:18 +0000
Subject: [PATCH v2 0/4] Add support for the Cortex A5 global timer
Message-ID: <1394792302-24451-1-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the global timer with the Cortex
A5. This is relatively simple patch series and mainly consists of:

 - Update a check in the drive probe code for an unusable global timer
   to be non-specific to the A9.
 - Add the appropriate device tree node and Kconfig options.
 - Add a compatible node for the specific A5 global timer in the DT
   binding.

Changes since v1
================
- Retain information in the DT binding documentation that the driver
  will only work on a A9 r0p2 and above.

Any comments welcome.
Matt

Matthew Leach (4):
  clocksource: arm_global_timer: Only check for unusable timer on A9
  documentaion: DT: allow a A5 compatible string in global timer
  dts: ca5: add the global timer for the A5
  KConfig: Vexpress: build the ARM_GLOBAL_TIMER with vexpress platform

 Documentation/devicetree/bindings/arm/global_timer.txt |  7 +++++--
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts                | 10 +++++++++-
 arch/arm/mach-vexpress/Kconfig                         |  1 +
 drivers/clocksource/arm_global_timer.c                 |  5 +++--
 4 files changed, 18 insertions(+), 5 deletions(-)

-- 
1.8.5.3
