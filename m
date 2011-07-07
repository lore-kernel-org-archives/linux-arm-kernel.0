From: will.deacon@arm.com (Will Deacon)
Date: Thu, 7 Jul 2011 19:35:51 +0100
Subject: [GIT PULL v2] Cortex-A5 and Cortex-A15 support
Message-ID: <20110707183551.GD13534@e102144-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Firstly, thanks for the quick turnaround on Dave's patches; much
appreciated. Here's a new pull request for the updated branch.

In case anybody's interested, the original pull request is here:

http://lists.infradead.org/pipermail/linux-arm-kernel/2011-July/056547.html

Cheers,

Will



The following changes since commit b0af8dfdd67699e25083478c63eedef2e72ebd85:
  Linus Torvalds (1):
        Linux 3.0-rc5

are available in the git repository at:

  git://linux-arm.org/linux-2.6-wd.git for-rmk

Dave Martin (40):
      ARM: mm: proc-macros: Add generic proc/cache/tlb struct definition macros
      ARM: assembler.h: Add string declaration macro
      ARM: mm: cache-fa: Use the new processor struct macros
      ARM: mm: cache-v3: Use the new processor struct macros
      ARM: mm: cache-v4: Use the new processor struct macros
      ARM: mm: cache-v4wb: Use the new processor struct macros
      ARM: mm: cache-v4wt: Use the new processor struct macros
      ARM: mm: cache-v6: Use the new processor struct macros
      ARM: mm: cache-v7: Use the new processor struct macros
      ARM: mm: proc-arm1020: Use the new processor struct macros
      ARM: mm: proc-arm1020e: Use the new processor struct macros
      ARM: mm: proc-arm1022: Use the new processor struct macros
      ARM: mm: proc-arm1026: Use the new processor struct macros
      ARM: mm: proc-arm6_7: Use the new processor struct macros
      ARM: mm: proc-arm720: Use the new processor struct macros
      ARM: mm: proc-arm740: Use the new processor struct macros
      ARM: mm: proc-arm7tdmi: Use the new processor struct macros
      ARM: mm: proc-arm920: Use the new processor struct macros
      ARM: mm: proc-arm922: Use the new processor struct macros
      ARM: mm: proc-arm925: Use the new processor struct macros
      ARM: mm: proc-arm926: Use the new processor struct macros
      ARM: mm: proc-arm940: Use the new processor struct macros
      ARM: mm: proc-arm946: Use the new processor struct macros
      ARM: mm: proc-arm9tdmi: Use the new processor struct macros
      ARM: mm: proc-fa526: Use the new processor struct macros
      ARM: mm: proc-feroceon: Use the new processor struct macros
      ARM: mm: proc-mohawk: Use the new processor struct macros
      ARM: mm: proc-sa110: Use the new processor struct macros
      ARM: mm: proc-sa1100: Use the new processor struct macros
      ARM: mm: proc-v6: Use the new processor struct macros
      ARM: mm: proc-v7: Use the new processor struct macros
      ARM: mm: proc-xsc3: Use new generic struct definition macros
      ARM: mm: proc-xscale: Use new generic struct definition macros
      ARM: mm: tlb-fa: Use the new processor struct macros
      ARM: mm: tlb-v3: Use the new processor struct macros
      ARM: mm: tlb-v4: Use the new processor struct macros
      ARM: mm: tlb-v4wb: Use the new processor struct macros
      ARM: mm: tlb-v4wbi: Use the new processor struct macros
      ARM: mm: tlb-v6: Use the new processor struct macros
      ARM: mm: tlb-v7: Use the new processor struct macros

Pawel Moll (2):
      ARM: proc: convert v7 proc infos into a common macro
      ARM: proc: add Cortex-A5 proc info

Will Deacon (10):
      Merge branch 'arm/proc-macros' of git://git.linaro.org/people/dmart/linux-2.6-arm into for-rmk
      ARM: hwcaps: use shifts instead of hardcoded constants
      ARM: hwcaps: add new HWCAP defines for ARMv7-A
      ARM: vfp: add VFPv4 capability detection and populate elf_hwcap
      ARM: proc: add proc info for Cortex-A15MP using classic page tables
      ARM: perf: remove confusing comment from v7 perf events backend
      ARM: perf: add PMUv2 common event definitions
      ARM: perf: add support for the Cortex-A5 PMU
      ARM: perf: add support for the Cortex-A15 PMU
      ARM: proc: add definition of cpu_reset for ARMv6 and ARMv7 cores

 arch/arm/include/asm/assembler.h  |    9 +
 arch/arm/include/asm/hwcap.h      |   36 ++--
 arch/arm/include/asm/perf_event.h |    2 +
 arch/arm/kernel/perf_event.c      |    6 +
 arch/arm/kernel/perf_event_v7.c   |  344 +++++++++++++++++++++++--
 arch/arm/kernel/setup.c           |    4 +
 arch/arm/mm/cache-fa.S            |   15 +-
 arch/arm/mm/cache-v3.S            |   15 +-
 arch/arm/mm/cache-v4.S            |   15 +-
 arch/arm/mm/cache-v4wb.S          |   15 +-
 arch/arm/mm/cache-v4wt.S          |   15 +-
 arch/arm/mm/cache-v6.S            |   15 +-
 arch/arm/mm/cache-v7.S            |   15 +-
 arch/arm/mm/proc-arm1020.S        |   45 +---
 arch/arm/mm/proc-arm1020e.S       |   52 +----
 arch/arm/mm/proc-arm1022.S        |   52 +----
 arch/arm/mm/proc-arm1026.S        |   53 +----
 arch/arm/mm/proc-arm6_7.S         |  166 +++----------
 arch/arm/mm/proc-arm720.S         |   85 ++-----
 arch/arm/mm/proc-arm740.S         |   42 +---
 arch/arm/mm/proc-arm7tdmi.S       |  216 +++-------------
 arch/arm/mm/proc-arm920.S         |   53 +----
 arch/arm/mm/proc-arm922.S         |   53 +----
 arch/arm/mm/proc-arm925.S         |   88 ++------
 arch/arm/mm/proc-arm926.S         |   51 +----
 arch/arm/mm/proc-arm940.S         |   51 +----
 arch/arm/mm/proc-arm946.S         |   53 +----
 arch/arm/mm/proc-arm9tdmi.S       |   78 ++-----
 arch/arm/mm/proc-fa526.S          |   38 +---
 arch/arm/mm/proc-feroceon.S       |  202 ++++-----------
 arch/arm/mm/proc-macros.S         |   63 +++++
 arch/arm/mm/proc-mohawk.S         |   61 ++---
 arch/arm/mm/proc-sa110.S          |   39 +---
 arch/arm/mm/proc-sa1100.S         |   84 ++-----
 arch/arm/mm/proc-v6.S             |   39 +--
 arch/arm/mm/proc-v7.S             |  136 +++++-----
 arch/arm/mm/proc-xsc3.S           |   90 ++------
 arch/arm/mm/proc-xscale.S         |  507 ++++++-------------------------------
 arch/arm/mm/tlb-fa.S              |    8 +-
 arch/arm/mm/tlb-v3.S              |    8 +-
 arch/arm/mm/tlb-v4.S              |    8 +-
 arch/arm/mm/tlb-v4wb.S            |    8 +-
 arch/arm/mm/tlb-v4wbi.S           |    8 +-
 arch/arm/mm/tlb-v6.S              |    8 +-
 arch/arm/mm/tlb-v7.S              |    9 +-
 arch/arm/vfp/vfpmodule.c          |    6 +-
 46 files changed, 913 insertions(+), 2053 deletions(-)
