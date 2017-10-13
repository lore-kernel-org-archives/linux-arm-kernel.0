From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 13 Oct 2017 16:29:37 +0100
Subject: [GIT PULL] ACPI IORT changes for v4.15
Message-ID: <20171013152937.GA13386@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Will,

here are the ACPI IORT changes I have queued aimed at the v4.15 kernel
release.

Main changes:

- SMMUv3 MSI enablement work based on IORT issue C spec updates
  (Hanjun Guo)
- Clean-ups/rework in preparation for PMCG support (Lorenzo Pieralisi)

Patches have a compile time dependency on the ACPICA tree that we handled
through an ACPI_CA_VERSION guard; I will remove it at v4.15-rc1 when
dependencies have settled.

Reference discussion:

http://lkml.kernel.org/r/20171013130445.GA27895 at red-moon

I expect no merge conflict with the arm64 tree for-next/core branch.

Patches are based on v4.14-rc4 owing to an IORT dependency on a fix
(ie commit 37f6b42e9c ("ACPI/IORT: Fix PCI ACS enablement")) that
was merged in v4.14-rc4.

Please consider pulling, thank you.

Lorenzo

-- >8 --
The following changes since commit 8a5776a5f49812d29fe4b2d0a2d71675c3facf3f:

  Linux 4.14-rc4 (2017-10-08 20:53:29 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/acpi/iort-for-v4.15

for you to fetch changes up to 9729b8a405980275e1deae7e163ecd30c6f56e33:

  ACPI/IORT: Enable SMMUv3/PMCG IORT MSI domain set-up (2017-10-13 12:40:53 +0100)

----------------------------------------------------------------
ACPI IORT updates for v4.15; patches content is logically split into
the following subseries:

- Code clean-ups (A.Yadav, L.Pieralisi)
- Platform devices inizialization rework in preparation for IORT PMCG
  handling (L.Pieralisi)
- Mapping API rework to enable MSIs for IORT components as defined in
  IORT specification issue C (H.Guo, L.Pieralisi)

----------------------------------------------------------------
Arvind Yadav (1):
      acpi/arm64: pr_err() strings should end with newlines

Hanjun Guo (3):
      ACPI/IORT: Look up IORT node through struct fwnode_handle pointer
      ACPI/IORT: Enable special index ITS group mappings for IORT nodes
      ACPI/IORT: Add SMMUv3 specific special index mapping handling

Lorenzo Pieralisi (4):
      ACPI/IORT: Remove leftover ACPI_IORT_SMMU_V3_PXM_VALID guard
      ACPI/IORT: Improve functions return type/storage class specifier indentation
      ACPI/IORT: Make platform devices initialization code SMMU agnostic
      ACPI/IORT: Enable SMMUv3/PMCG IORT MSI domain set-up

 drivers/acpi/arm64/gtdt.c |   2 +-
 drivers/acpi/arm64/iort.c | 258 +++++++++++++++++++++++++++++++++++-----------
 include/linux/acpi_iort.h |   4 +-
 3 files changed, 203 insertions(+), 61 deletions(-)
