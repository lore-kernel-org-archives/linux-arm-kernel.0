From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 12 Apr 2013 17:27:39 -0700
Subject: [PATCHv2 0/4] Memory mapped architected timers
Message-ID: <1365812863-5367-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for memory mapped architected timers. We
don't have any other global broadcast timer in our system, so we use the
mmio timer during low power modes. The first patch is the binding.
The next two patches lay some groundwork so that the last patch is simpler.
The final patch adds support for mmio timers.

Patches are based on a recent patch from Mark that removes the
physical count reading (clocksource: arch_timer: use virtual counter,
message id <1364404312-4427-4-git-send-email-mark.rutland@arm.com>).

Updates since v1:
 * Assigned counter reading function and commented why for arm64
 * Updated DT binding to replace frame-id with frame-number and use status
   property

Stephen Boyd (4):
  Documentation: Add memory mapped ARM architected timer binding
  ARM: arch_timers: Pass clock event to set_mode callback
  clocksource: arch_timer: Push the read/write wrappers deeper
  clocksource: arch_timer: Add support for memory mapped timers

 .../devicetree/bindings/arm/arch_timer.txt         |  59 ++-
 arch/arm/include/asm/arch_timer.h                  |   5 +-
 arch/arm64/include/asm/arch_timer.h                |   4 +-
 drivers/clocksource/arm_arch_timer.c               | 455 +++++++++++++++++----
 include/clocksource/arm_arch_timer.h               |   4 +-
 5 files changed, 449 insertions(+), 78 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
