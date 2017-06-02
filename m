From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 2 Jun 2017 18:18:22 +0100
Subject: [GIT PULL] arm64 fixes for 4.12-rc4
Message-ID: <20170602171819.GA20872@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Please pull the arm64 fixes below. Thanks.

The following changes since commit 63a1e1c95e60e798fa09ab3c536fb555aa5bbf2b:

  arm64/cpufeature: don't use mutex in bringup path (2017-05-17 17:00:29 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux tags/arm64-fixes

for you to fetch changes up to cb7cf772d83d2d4e6995c5bb9e0fb59aea8f7080:

  ARM64/ACPI: Fix BAD_MADT_GICC_ENTRY() macro implementation (2017-06-02 15:13:52 +0100)

----------------------------------------------------------------
ACPI-related fixes for arm64:

- GICC MADT entry validity check fix

- Skip IRQ registration with pmu=off in an ACPI guest

- struct acpi_pci_root_ops freeing on error path

----------------------------------------------------------------
Lorenzo Pieralisi (1):
      ARM64/ACPI: Fix BAD_MADT_GICC_ENTRY() macro implementation

Timmy Li (1):
      ARM64: PCI: Fix struct acpi_pci_root_ops allocation failure path

Wei Huang (1):
      drivers/perf: arm_pmu_acpi: avoid perf IRQ init when guest PMU is off

 arch/arm64/include/asm/acpi.h |  6 +++---
 arch/arm64/kernel/pci.c       |  4 +++-
 drivers/perf/arm_pmu_acpi.c   | 11 +++++++++++
 3 files changed, 17 insertions(+), 4 deletions(-)

-- 
Catalin
