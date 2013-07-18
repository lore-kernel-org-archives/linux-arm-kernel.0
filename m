From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 18 Jul 2013 16:59:27 -0700
Subject: [PATCH v4 0/5] Memory mapped architected timers
Message-ID: <1374191972-18015-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds support for memory mapped architected timers. We
don't have any other global broadcast timer in our system, so we use the
mmio timer during low power modes. The first patch changes the register
accessor to an enum per Thomas' request. The second patch is the binding.
The next two patches lay some groundwork so that the last patch is simpler.
The final patch adds support for mmio timers.

Patches are based on v3.11-rc1.

Updates since v3:
 * Rebased onto v3.11-rc1
 * New patch to use compiler warnings instead of BUILD_BUG_ON()

Updates since v2:
 * Rebased onto v3.10-rc1

Updates since v1:
 * Assigned counter reading function and commented why for arm64
 * Updated DT binding to replace frame-id with frame-number and use status
   property


Stephen Boyd (5):
  clocksource: arch_timer: Make register accessors less error-prone
  Documentation: Add memory mapped ARM architected timer binding
  clocksource: arch_timer: Pass clock event to set_mode callback
  clocksource: arch_timer: Push the read/write wrappers deeper
  clocksource: arch_timer: Add support for memory mapped timers

 .../devicetree/bindings/arm/arch_timer.txt         |  59 ++-
 arch/arm/include/asm/arch_timer.h                  |  14 +-
 arch/arm64/include/asm/arch_timer.h                |  23 +-
 drivers/clocksource/arm_arch_timer.c               | 446 +++++++++++++++++----
 include/clocksource/arm_arch_timer.h               |  10 +-
 5 files changed, 455 insertions(+), 97 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
