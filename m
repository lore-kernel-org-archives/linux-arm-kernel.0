From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 Sep 2017 17:44:08 +0100
Subject: [GIT PULL] arm64 fixes for 4.14-rc2
Message-ID: <20170922164406.hizswjk7yh4injvr@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.


The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to a88dc7ba15cd4f4ef5102b5185f8fa7ff86e54e1:

  drivers/perf: arm_pmu_acpi: Release memory obtained by kasprintf (2017-09-22 15:11:46 +0100)

----------------------------------------------------------------
arm64 fixes:

- #ifdef CONFIG_EFI around __efi_fpsimd_begin/end

- Assembly code alignment reduced to 4 bytes from 16

- Ensure the kernel is compiled for LP64 (there are some arm64 compilers
  around defaulting to ILP32)

- Fix arm_pmu_acpi memory leak on the error path

----------------------------------------------------------------
Andrew Pinski (1):
      arm64: ensure the kernel is compiled for LP64

Arvind Yadav (1):
      drivers/perf: arm_pmu_acpi: Release memory obtained by kasprintf

Dave Martin (1):
      arm64: efi: Don't include EFI fpsimd save/restore code in non-EFI kernels

Masahiro Yamada (1):
      arm64: relax assembly code alignment from 16 byte to 4 byte

 arch/arm64/Makefile              | 5 +++++
 arch/arm64/include/asm/linkage.h | 4 ++--
 arch/arm64/kernel/fpsimd.c       | 4 ++++
 drivers/perf/arm_pmu_acpi.c      | 1 +
 4 files changed, 12 insertions(+), 2 deletions(-)

-- 
Catalin
