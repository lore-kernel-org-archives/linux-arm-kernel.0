From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Fri, 02 Aug 2013 10:45:10 +0200
Subject: [GIT PULL] clocksource/clockevents : arch_timer memory mapped support
Message-ID: <51FB7196.6060809@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 07862c1cd6675cde2dd4bd64e64d704ea2185b79:

  ARM: clocksource: Add support for MOXA ART SoCs (2013-07-18 15:27:47
+0200)

are available in the git repository at:

  git://git.linaro.org/people/dlezcano/clockevents.git
timers/clockevents-next

for you to fetch changes up to 220069945b298d3998c6598b081c466dca259929:

  clocksource: arch_timer: Add support for memory mapped timers
(2013-08-01 01:13:37 +0200)
----------------------------------------------------------------

This series contains some trivial fixes for the moxart driver:
documentation updates and a missing header file.

It also provides the arch_timer memory mapped support.

----------------------------------------------------------------
Jonas Jensen (3):
      ARM: clocksource: moxart: documentation: Fix device tree bindings
document
      ARM: clocksource: moxart: Add bitops.h include
      ARM: clocksource: moxart: documentation: Update device tree
bindings document

Stephen Boyd (5):
      clocksource: arch_timer: Make register accessors less error-prone
      clocksource: arch_timer: Pass clock event to set_mode callback
      Documentation: Add memory mapped ARM architected timer binding
      clocksource: arch_timer: Push the read/write wrappers deeper
      clocksource: arch_timer: Add support for memory mapped timers

 .../devicetree/bindings/arm/arch_timer.txt         |   59 ++-
 .../bindings/timer/moxa,moxart-timer.txt           |    6 +-
 arch/arm/include/asm/arch_timer.h                  |   14 +-
 arch/arm64/include/asm/arch_timer.h                |   23 +-
 drivers/clocksource/arm_arch_timer.c               |  446
+++++++++++++++++---
 drivers/clocksource/moxart_timer.c                 |    1 +
 include/clocksource/arm_arch_timer.h               |   10 +-
 7 files changed, 459 insertions(+), 100 deletions(-)

-- 
 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
