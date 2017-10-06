From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 6 Oct 2017 19:24:28 +0100
Subject: [GIT PULL] arm64 fixes for 4.14-rc4
Message-ID: <20171006182426.udiie6pplnklwv5a@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 9e66317d3c92ddaab330c125dfe9d06eee268aff:

  Linux 4.14-rc3 (2017-10-01 14:54:54 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to ae2e972dae3cea795e9f8f94eb1601213c2d49f0:

  arm64: Ensure fpsimd support is ready before userspace is active (2017-10-06 16:35:25 +0100)

----------------------------------------------------------------
arm64 fixes:

- Bring initialisation of user space undefined instruction handling
  early (core_initcall) since late_initcall() happens after modprobe in
  initramfs is invoked. Similar fix for fpsimd initialisation

- Increase the kernel stack when KASAN is enabled

- Bring the PCI ACS enabling earlier via the
  iort_init_platform_devices()

- Fix misleading data abort address printing (decimal vs hex)

----------------------------------------------------------------
Lorenzo Pieralisi (1):
      ACPI/IORT: Fix PCI ACS enablement

Mark Rutland (2):
      arm64: fix misleading data abort decoding
      arm64: Use larger stacks when KASAN is selected

Suzuki K Poulose (2):
      arm64: Ensure the instruction emulation is ready for userspace
      arm64: Ensure fpsimd support is ready before userspace is active

 arch/arm64/include/asm/memory.h      |  9 ++++++---
 arch/arm64/kernel/armv8_deprecated.c |  2 +-
 arch/arm64/kernel/cpufeature.c       |  2 +-
 arch/arm64/kernel/fpsimd.c           |  2 +-
 arch/arm64/mm/fault.c                |  2 +-
 drivers/acpi/arm64/iort.c            | 35 +++++++++++++++++++++++++++++++++++
 6 files changed, 45 insertions(+), 7 deletions(-)

-- 
Catalin
