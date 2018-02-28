From: alex.shi@linaro.org (Alex Shi)
Date: Wed, 28 Feb 2018 11:56:22 +0800
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9 
Message-ID: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi All,

This backport patchset fixed the meltdown issue, it's original branch:
https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
A few dependency or fixingpatches are also picked up, if they are necessary
 and no functional changes.

The patchset also on repository:
	git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2 

No bug found yet from kernelci.org and lkft testing.

Any comments are appreciated!

Regards
Alex

---
AKASHI Takahiro (1):
      module: extend 'rodata=off' boot cmdline parameter to module mappings

Jayachandran C (2):
      arm64: cputype: Add MIDR values for Cavium ThunderX2 CPUs
      arm64: Turn on KPTI only on CPUs that need it

Marc Zyngier (2):
      arm64: Allow checking of a CPU-local erratum
      arm64: Force KPTI to be disabled on Cavium ThunderX

Mark Rutland (1):
      arm64: factor out entry stack manipulation

Suzuki K Poulose (1):
      arm64: capabilities: Handle duplicate entries for a capability

Will Deacon (21):
      arm64: mm: Use non-global mappings for kernel space
      arm64: mm: Move ASID from TTBR0 to TTBR1
      arm64: mm: Allocate ASIDs in pairs
      arm64: mm: Add arm64_kernel_unmapped_at_el0 helper
      arm64: mm: Invalidate both kernel and user ASIDs when performing TLBI
      arm64: entry: Add exception trampoline page for exceptions from EL0
      arm64: mm: Map entry trampoline into trampoline and kernel page tables
      arm64: entry: Explicitly pass exception level to kernel_ventry macro
      arm64: entry: Hook up entry trampoline to exception vectors
      arm64: tls: Avoid unconditional zeroing of tpidrro_el0 for native tasks
      arm64: entry: Add fake CPU feature for unmapping the kernel at EL0
      arm64: kaslr: Put kernel vectors address in separate data page
      arm64: use RET instruction for exiting the trampoline
      arm64: Kconfig: Add CONFIG_UNMAP_KERNEL_AT_EL0
      arm64: Kconfig: Reword UNMAP_KERNEL_AT_EL0 kconfig entry
      arm64: Take into account ID_AA64PFR0_EL1.CSV3
      arm64: cputype: Add missing MIDR values for Cortex-A72 and Cortex-A75
      arm64: kpti: Make use of nG dependent on arm64_kernel_unmapped_at_el0()
      arm64: kpti: Add ->enable callback to remap swapper using nG mappings
      arm64: entry: Reword comment about post_ttbr_update_workaround
      arm64: idmap: Use "awx" flags for .idmap.text .pushsection directives

Xie XiuQi (1):
      arm64: entry.S: move SError handling into a C function for future expansion
