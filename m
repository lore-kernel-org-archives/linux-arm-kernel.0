From: matthew.leach@arm.com (Matthew Leach)
Date: Mon, 10 Mar 2014 11:51:30 +0000
Subject: [PATCH 0/4] Add support for the Cortex A5 global timer
Message-ID: <1394452294-24552-1-git-send-email-matthew.leach@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series adds support for the global timer with the Cortex
A5. This is relatively simple patch series and mainly consists of:

 - Update a check in the drive probe code for an unusable global timer
   to be non-specific to the A9.
 - Add the appropriate device tree node and Kconfig options.
 - Add a compatible node for the specifc A5 global timer in the DT
   binding.

Any comments welcome.
Matt

Matthew Leach (4):
  clocksource: arm_global_timer: Only check for unusable timer on A9
  documentaion: DT: allow a A5 compatible string in global timer
  dts: ca5: add the global timer for the A5
  KConfig: Vexpress: build the ARM_GLOBAL_TIMER with vexpress platform

 Documentation/devicetree/bindings/arm/global_timer.txt |  6 ++++--
 arch/arm/boot/dts/vexpress-v2p-ca5s.dts                | 10 +++++++++-
 arch/arm/mach-vexpress/Kconfig                         |  1 +
 drivers/clocksource/arm_global_timer.c                 |  5 +++--
 4 files changed, 17 insertions(+), 5 deletions(-)

-- 
1.8.5.3
