From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 9 Aug 2017 10:57:29 +0100
Subject: [GIT PULL] ARM64 ACPI IORT changes for v4.14
Message-ID: <20170809095729.GA12715@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin, Will,

please find below IORT changes aimed at the v4.14 release window:

- A patch from R.Murphy to improve current PCI aliases detection and
  corresponding IOMMU streamid parsing/initialization
- A patch from G.Kulkarni to add IOMMU IORT NUMA detection in the IORT
  kernel layer following IORT specs update

These are not the only IORT patches for this merge window - other
changes will go via IOMMU/ACPI trees and I expect no conflicts
with them.

Please consider pulling, thanks,

Lorenzo

The following changes since commit aae4e7a8bc44722fe70d58920a36916b1043195e:

  Linux 4.13-rc4 (2017-08-06 18:44:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lpieralisi/linux.git tags/arm64-iort-for-v4.14

for you to fetch changes up to 5fe0ce3b9e514168427463d0c7a86dfa635da3d2:

  ACPI/IORT: numa: Add numa node mapping for smmuv3 devices (2017-08-08 16:44:38 +0100)

----------------------------------------------------------------
Two patches for the 4.14 release merge window:

- IORT PCI aliases detection improvement to cater for systems with
  complex PCI topologies that current code mishandles (R.Murphy)
- IORT SMMUv3 proximity domain (ie NUMA) handling (respective ACPICA
  changes will be merged separately) (G. Kulkarni)

----------------------------------------------------------------
Ganapatrao Kulkarni (1):
      ACPI/IORT: numa: Add numa node mapping for smmuv3 devices

Robin Murphy (1):
      ACPI/IORT: Handle PCI aliases properly for IOMMUs

 drivers/acpi/arm64/iort.c | 140 ++++++++++++++++++++++++++++------------------
 1 file changed, 87 insertions(+), 53 deletions(-)
