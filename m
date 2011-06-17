From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Jun 2011 09:19:30 +0100
Subject: [PATCH v3 00/10] Core support for Cortex-A5 and Cortex-A15
Message-ID: <1308298780-28000-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is version 3 of the patches originally posted here:

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052141.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2011-June/052426.html

Changes from v2 include:

   * Use named parameter for supplying hwcaps to proc macro
   * Based on -rc3

Tested on Realview-PBX (Cortex-A9) without regressions. Also tested on
Cortex-A5 (w/ NEON) and Cortex-A15 (w/ NEON).

I've also applied and tested these successfully on top of Dave Martin's
generic macro patches (with the string declaration bits backed out) so I
believe they should be fit for inclusion in 3.1 in their current state.
That said, all feedback is more than welcome.

Thanks,

Will


Pawel Moll (2):
  arm: Convert v7 proc infos into a common macro
  arm: Add Cortex A5 proc info

Will Deacon (8):
  ARM: hwcaps: use shifts instead of hardcoded constants
  ARM: hwcaps: add new HWCAP defines for ARMv7-A
  ARM: proc: add proc info for Cortex-A15MP using classic page tables
  ARM: vfp: add VFPv4 capability detection and populate elf_hwcap
  ARM: perf: remove confusing comment from v7 perf events backend
  ARM: perf: add PMUv2 common event definitions
  ARM: perf: add support for the Cortex-A5 PMU
  ARM: perf: add support for the Cortex-A15 PMU

 arch/arm/include/asm/hwcap.h      |   36 ++--
 arch/arm/include/asm/perf_event.h |    2 +
 arch/arm/kernel/perf_event.c      |    6 +
 arch/arm/kernel/perf_event_v7.c   |  344 ++++++++++++++++++++++++++++++++++--
 arch/arm/kernel/setup.c           |    4 +
 arch/arm/mm/proc-v7.S             |   98 ++++++-----
 arch/arm/vfp/vfpmodule.c          |    6 +-
 7 files changed, 413 insertions(+), 83 deletions(-)
