From: will.deacon@arm.com (Will Deacon)
Date: Fri, 9 Jan 2015 15:22:18 +0000
Subject: [GIT PULL] arm64: fixes for -rc4
Message-ID: <20150109152217.GD11258@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Here is a handful of minor arm64 fixes discovered and fixed over the
Christmas break. The main part is adding some missing #includes that we
seem to be getting transitively but have started causing problems in
-next. Please pull.

Thanks,

Will

--->8

The following changes since commit b1940cd21c0f4abdce101253e860feff547291b0:

  Linux 3.19-rc3 (2015-01-05 17:05:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git tags/arm64-fixes

for you to fetch changes up to 0e63ea48b4d8035dd0e91a3fa6fb79458b47adfb:

  arm64/efi: add missing call to early_ioremap_reset() (2015-01-08 11:57:04 +0000)

----------------------------------------------------------------
arm64 fixes:
- Fix early mapping fixmap corruption by EFI runtime services
- Fix __NR_compat_syscalls off-by-one
- Add missing sanity checks for some 32-bit registers
- Add some missing #includes which we get transitively
- Remove unused prepare_to_copy() macro

----------------------------------------------------------------
Ard Biesheuvel (1):
      arm64/efi: add missing call to early_ioremap_reset()

Mark Rutland (2):
      arm64: Correct __NR_compat_syscalls for bpf
      arm64: sanity checks: add missing AArch32 registers

Paul Walmsley (4):
      arm64: fix missing asm/pgtable-hwdef.h include in asm/processor.h
      arm64: fix missing linux/bug.h include in asm/arch_timer.h
      arm64: fix missing asm/alternative.h include in kernel/module.c
      arm64: fix missing asm/io.h include in kernel/smp_spin_table.c

Tobias Klauser (1):
      arm64: Remove unused prepare_to_copy()

 arch/arm64/include/asm/arch_timer.h |  1 +
 arch/arm64/include/asm/cpu.h        |  5 +++++
 arch/arm64/include/asm/processor.h  |  4 +---
 arch/arm64/include/asm/unistd.h     |  2 +-
 arch/arm64/kernel/cpuinfo.c         | 10 ++++++++++
 arch/arm64/kernel/efi.c             |  2 +-
 arch/arm64/kernel/module.c          |  1 +
 arch/arm64/kernel/setup.c           |  1 +
 arch/arm64/kernel/smp_spin_table.c  |  1 +
 9 files changed, 22 insertions(+), 5 deletions(-)
