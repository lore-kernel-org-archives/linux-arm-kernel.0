From: robherring2@gmail.com (Rob Herring)
Date: Mon, 11 Mar 2013 21:26:34 -0500
Subject: [PATCH 0/3] ARM sched_clock selection enhancements
Message-ID: <1363055197-17296-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <rob.herring@calxeda.com>

In preparation to move more timer initialization to use CLKSRC_OF and
out of the platforms, a way to select the timer used for sched_clock is
needed. This series makes the ARM sched_clock support code prefer 64-bit
counters or higher frequency counters. This is sufficient at least on
ARM Ltd boards to use the 24MHz counter rather than sp804 and to always
use the 64-bit architected timer when present. This mechanism can be
extended to DT properties if needed for any non-discoverable h/w feature.

Rob

Rob Herring (3):
  ARM: sched_clock: allow changing to higher frequency counter
  ARM: sched_clock: support 64-bit counters
  ARM: arch_timer: use the 64-bit sched_clock setup

 arch/arm/include/asm/sched_clock.h |    1 +
 arch/arm/kernel/arch_timer.c       |    8 +-------
 arch/arm/kernel/sched_clock.c      |   35 ++++++++++++++++++++++++++++++++---
 3 files changed, 34 insertions(+), 10 deletions(-)

-- 
1.7.10.4
