From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 31 Mar 2017 11:02:26 +0100
Subject: [GIT PULL] ACPI IORT changes for v4.12
Message-ID: <20170331100226.GA30762@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Will,

I have collected the following ACPI/IORT patches for the 4.12 release:

- IORT interface minor clean-ups
- IORT platform devices (IORT named components) devid mapping interface
  implementation
- ACPI core changes to enable platform MSIs

ACPI core changes have been acknowledged by the ACPI maintainer and
I reviewed/updated the IORT patches.

This pull request provides the groundwork to implement platform MSIs
in ACPI for ARM64, the irqchip changes enabling GIC ITS platform
MSIs will be merged via the irqchip tree.

Please consider pulling it.

Thanks !
Lorenzo

The following changes since commit 97da3854c526d3a6ee05c849c96e48d21527606c:

  Linux 4.11-rc3 (2017-03-19 19:09:39 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/acpi-arm64-for-v4.12

for you to fetch changes up to d4f54a186667ffd19eac8e3f48c51d940a9b9784:

  ACPI: platform: setup MSI domain for ACPI based platform device (2017-03-30 10:20:01 +0100)

----------------------------------------------------------------
ACPI ARM64 specific changes for v4.12.

Patches contain:

- IORT kernel interface misc clean-ups
- IORT id mapping interface refactoring in preparation for platform
  MSI (IORT named components -> GIC ITS mappings) devid mapping code
- IORT id mapping implementation for named components nodes to ITS nodes,
  in order to provide the kernel with a firmware interface to map
  platform devices devids to GIC ITS components

----------------------------------------------------------------
Hanjun Guo (7):
      ACPI/IORT: Fix the indentation in iort_scan_node()
      ACPI/IORT: Add missing comment for iort_dev_find_its_id()
      ACPI/IORT: Rework iort_match_node_callback() return value handling
      ACPI/IORT: Rename iort_node_map_rid() to make it generic
      ACPI/IORT: Introduce iort_node_map_platform_id() to retrieve dev id
      ACPI: platform-msi: retrieve devid from IORT
      ACPI: platform: setup MSI domain for ACPI based platform device

 drivers/acpi/arm64/iort.c | 158 +++++++++++++++++++++++++++++++++++++---------
 drivers/acpi/glue.c       |   6 ++
 include/linux/acpi_iort.h |   3 +
 3 files changed, 136 insertions(+), 31 deletions(-)
