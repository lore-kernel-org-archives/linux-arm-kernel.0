From: Sudeep.KarkadaNagesha@arm.com (Sudeep KarkadaNagesha)
Date: Thu, 29 Aug 2013 18:13:59 +0100
Subject: [GIT PULL] ARM/ARM64 architected timer updates for v3.12
Message-ID: <521F8157.20203@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Daniel,

These are the ARM/ARM64 arch timer updates for v3.12.
I have re-based the changes on tip/timers/core as there are conflicts
with memory mapped arch_timers support queued recently.
Since this series adds CPU PM notifiers for arch_timers, it is required
to enable ARM bL cpuidle drivers(already queued for v3.12)

Regards,
Sudeep

The following changes since commit cfb6d656d569510ac9239583ce09e4c92ad54719:

  Merge branch 'timers/clockevents-next' of
git://git.linaro.org/people/dlezcano/clockevents into timers/core
(2013-08-21 14:59:23 +0200)

are available in the git repository at:


  git://linux-arm.org/linux-skn.git timer_evtstrm

for you to fetch changes up to f74f198e540c160b1db9470b679dbeb72339829b:

  drivers: clocksource: add CPU PM notifier for ARM architected timer
(2013-08-29 17:43:08 +0100)

----------------------------------------------------------------
Sudeep KarkadaNagesha (4):
   ARM/ARM64: arch_timer: add macros for bits in control register
   ARM: arch_timer: add support to configure and enable event stream
   ARM64: arch_timer: add support to configure and enable event stream
   drivers: clocksource: add CPU PM notifier for ARM architected timer

Will Deacon (1):
   drivers: clocksource: add support for ARM architected timer event stream
q
 arch/arm/include/asm/arch_timer.h    | 36 ++++++++++++++++---
 arch/arm/include/uapi/asm/hwcap.h    |  1 +
 arch/arm/kernel/setup.c              |  1 +
 arch/arm64/include/asm/arch_timer.h  | 42 ++++++++++++++++++---
 arch/arm64/include/asm/hwcap.h       | 11 +++---
 arch/arm64/include/uapi/asm/hwcap.h  |  1 +
 arch/arm64/kernel/setup.c            | 11 ++++++
 drivers/clocksource/Kconfig          | 15 ++++++++
 drivers/clocksource/arm_arch_timer.c | 49 +++++++++++++++++++++++++
 include/clocksource/arm_arch_timer.h | 10 +++++
 10 files changed, 161 insertions(+), 16 deletions(-)
