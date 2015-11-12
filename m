From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 12 Nov 2015 18:05:08 +0000
Subject: [GIT PULL] arm64 fixes for 4.4-rc1
Message-ID: <20151112180504.GA10702@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here's a second pull request for this merging window with some
fixes/clean-ups (on top of the initial request, based on 4.3-rc4).
Thanks.

The following changes since commit f8f8bdc48851da979c6e0e4808b6031122e4af47:

  arm64/efi: fix libstub build under CONFIG_MODVERSIONS (2015-11-02 13:50:17 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to 01b305a234943c25c336a6f2f77932a4eaf125fa:

  arm64: suspend: make hw_breakpoint_restore static (2015-11-12 15:18:14 +0000)

----------------------------------------------------------------
arm64 fixes and clean-ups:

- __cmpxchg_double*() return type fix to avoid truncation of a long to
  int and subsequent logical "not" in cmpxchg_double() misinterpreting
  the operation success/failure
- BPF fixes for mod and div by zero
- Fix compilation with STRICT_MM_TYPECHECKS enabled
- VDSO build fix without libgcov
- Some static and __maybe_unused annotations
- Kconfig clean-up (FRAME_POINTER)
- defconfig update for CRYPTO_CRC32_ARM64

----------------------------------------------------------------
Ard Biesheuvel (2):
      arm64: fix STRICT_MM_TYPECHECKS issue in PTE_CONT manipulation
      arm64: fix R/O permissions of FDT mapping

Arnd Bergmann (3):
      arm64: mark cpus_have_hwcap as __maybe_unused
      arm64: build vdso without libgcov
      arm64: use linux/types.h in kvm.h

Catalin Marinas (1):
      arm64: Enable CRYPTO_CRC32_ARM64 in defconfig

Jisheng Zhang (3):
      arm64: smp: make of_parse_and_init_cpus static
      arm64: mmu: make split_pud and fixup_executable static
      arm64: suspend: make hw_breakpoint_restore static

Lorenzo Pieralisi (1):
      arm64: cmpxchg_dbl: fix return value type

Yang Shi (1):
      arm64: remove redundant FRAME_POINTER kconfig option and force to select it

Zi Shen Lim (2):
      arm64: bpf: fix div-by-zero case
      arm64: bpf: fix mod-by-zero case

 arch/arm64/Kconfig                    |  1 +
 arch/arm64/Kconfig.debug              |  4 ---
 arch/arm64/configs/defconfig          |  1 +
 arch/arm64/include/asm/atomic_ll_sc.h |  2 +-
 arch/arm64/include/asm/atomic_lse.h   |  2 +-
 arch/arm64/include/asm/pgtable.h      |  1 +
 arch/arm64/include/uapi/asm/kvm.h     |  2 +-
 arch/arm64/kernel/cpufeature.c        |  2 +-
 arch/arm64/kernel/smp.c               |  2 +-
 arch/arm64/kernel/suspend.c           |  2 +-
 arch/arm64/kernel/vdso/Makefile       |  3 ++
 arch/arm64/mm/mmu.c                   |  8 +++---
 arch/arm64/net/bpf_jit.h              |  3 +-
 arch/arm64/net/bpf_jit_comp.c         | 54 +++++++++++++++++++++++------------
 14 files changed, 54 insertions(+), 33 deletions(-)

-- 
Catalin
