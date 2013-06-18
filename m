From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Tue, 18 Jun 2013 18:06:59 +0100
Subject: [PATCH 0/4] ARM/ARM64 architected timer updates
Message-ID: <1371575223-21702-1-git-send-email-Sudeep.KarkadaNagesha@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sudeep KarkadaNagesha <sudeep.karkadanagesha@arm.com>

Hi,

This patch series adds support to configure the rate and enable the event
stream for architected timer. Since the timer control register is reset to
zero on warm boot, CPU PM notifier is added to re-initialse it.

Regards,
Sudeep

Sudeep KarkadaNagesha (3):
  ARM: arch_timer: add macros for bits in control register
  ARM/ARM64: arch_timer: remove __cpuinit attribute for
    arch_counter_set_user_access
  drivers: clocksource: add CPU PM notifier for ARM architected timer

Will Deacon (1):
  drivers: clocksource: configure event stream for ARM arch timer

 arch/arm/include/asm/arch_timer.h    | 10 ++++++--
 arch/arm64/include/asm/arch_timer.h  | 12 +++++++---
 drivers/clocksource/arm_arch_timer.c | 46 +++++++++++++++++++++++++++++++++++-
 include/clocksource/arm_arch_timer.h | 10 ++++++++
 4 files changed, 72 insertions(+), 6 deletions(-)

-- 
1.8.1.2
