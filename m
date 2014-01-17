From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 17 Jan 2014 10:03:24 +0800
Subject: [PATCH 0/3] ACPI: Some patches to prepare for running ACPI on !x86
 and !ia64
Message-ID: <1389924207-7360-1-git-send-email-hanjun.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Some of the ACPI code is arch-dependent and make the code can't be
compiled on !x86 and !ia64, the first two patches just do some rework
on the idle_boot_override and _PDC related stuff to make the ACPI
code more arch-independent.

The third patch just introduce map_gic_id() for ACPI processor core
followed by the ACPI 5.0 spec.

These three patches are just ACPI related so I send them out as
a separate patch set.

I have compiled the kernel successful after appling this patch set
on x86, ia64 and powerpc(with cross compile tool).

Changes since last RFC version:
a) Remove the RFC tag;
b) Move idle_boot_override out of the arch directory suggested
   by Alan;
c) Make these 3 patches as a separate patch set since there are
   not not related to the ARM/ARM64 platform.

Hanjun Guo (3):
  ACPI / idle: Move idle_boot_override out of the arch directory
  ACPI / processor_core: Rework _PDC related stuff to make it more
    arch-independent
  ACPI: Introduce map_gic_id() to get apic id from MADT or _MAT method

 arch/ia64/include/asm/acpi.h         |  5 +---
 arch/ia64/include/asm/processor.h    |  3 ---
 arch/ia64/kernel/acpi.c              | 17 +++++++++++++
 arch/powerpc/include/asm/processor.h |  1 -
 arch/x86/include/asm/acpi.h          | 19 +--------------
 arch/x86/include/asm/processor.h     |  3 ---
 arch/x86/kernel/acpi/cstate.c        | 31 ++++++++++++++++++++++++
 arch/x86/kernel/process.c            |  1 +
 drivers/acpi/processor_core.c        | 47 +++++++++++++++++++++---------------
 include/linux/cpu.h                  |  8 ++++++
 10 files changed, 87 insertions(+), 48 deletions(-)

-- 
1.8.2.2
