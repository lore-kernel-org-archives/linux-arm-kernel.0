From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 6 Feb 2017 13:38:56 +0000
Subject: [GIT PULL] ACPI IORT fixes for v4.10-rc8
Message-ID: <20170206133856.GA14139@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will, Catalin,

please consider pulling a couple of minor ACPI IORT fixes that were
missed in the last few -rc* cycles but should be considered for
merging as soon as possible, hopefully before v4.10 is released.

Thanks,
Lorenzo

The following changes since commit d5adbfcd5f7bcc6fa58a41c5c5ada0e5c826ce2c:

  Linux 4.10-rc7 (2017-02-05 15:10:58 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/iort-fixes-for-v4.10

for you to fetch changes up to 2a42d9d5dd259b0bdef34a00da426ac5fb0261e1:

  ACPI/IORT: Fix the error return code in iort_add_smmu_platform_device() (2017-02-06 12:50:53 +0000)

----------------------------------------------------------------
IORT fixes as a fall-out from IORT SMMU changes:

* Fix return value when IORT code allocating platform
  devices fails, that is causing a successful return
  on failure
* Fix the indexing in iort_node_get_id() so that the correct
  mapping entry is used to return the correct IORT parent
  node resulting from the mapping

----------------------------------------------------------------
Dan Carpenter (1):
      ACPI/IORT: Fix the error return code in iort_add_smmu_platform_device()

Lorenzo Pieralisi (1):
      ACPI/IORT: Fix iort_node_get_id() mapping entries indexing

 drivers/acpi/arm64/iort.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)
