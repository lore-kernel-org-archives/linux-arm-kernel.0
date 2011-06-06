From: will.deacon@arm.com (Will Deacon)
Date: Mon,  6 Jun 2011 17:55:44 +0100
Subject: [PATCH 00/11] Core support for Cortex-A5 and Cortex-A15
Message-ID: <1307379355-13802-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Here is a patch series for adding support for the Cortex-A5 and
Cortex-A15 cores to Linux. The first two patches (from Pawel) are
already in Russell's patch system, but I included them here for
completeness.

Anyway, the main thing is the HWCAP stuff as the perf stuff is all
rather boring.

Enjoy!

Will


Pawel Moll (2):
  arm: Convert v7 proc infos into a common macro
  arm: Add Cortex A5 proc info

Will Deacon (9):
  ARM: hwcaps: use shifts instead of hardcoded constants
  ARM: hwcaps: add new HWCAP defines for ARMv7-A
  ARM: proc: reorder macro parameters for __v7_proc macro
  ARM: cortex-a5: add HWCAP_VFPv4D16 to proc info structure
  ARM: proc: add proc info for Cortex-A15MP using classic page tables
  ARM: perf: remove confusing comment from v7 perf events backend
  ARM: perf: add PMUv2 common event definitions
  ARM: perf: add support for the Cortex-A5 PMU
  ARM: perf: add support for the Cortex-A15 PMU

 arch/arm/include/asm/hwcap.h      |   37 +++--
 arch/arm/include/asm/perf_event.h |    2 +
 arch/arm/kernel/perf_event.c      |    6 +
 arch/arm/kernel/perf_event_v7.c   |  344 ++++++++++++++++++++++++++++++++++--
 arch/arm/mm/proc-v7.S             |   98 ++++++-----
 5 files changed, 406 insertions(+), 81 deletions(-)
