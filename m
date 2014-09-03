From: will.deacon@arm.com (Will Deacon)
Date: Wed, 3 Sep 2014 16:48:22 +0100
Subject: [GIT PULL] iommu/arm-smmu: fixes for 3.17
Message-ID: <20140903154822.GG32378@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

Please can you pull the following arm-smmu fixes for 3.17? They address
a variety of issues found by running the driver on more hardware and
also by the vSMMU work I've been doing.

The only change from the series I posted to the list [1] is that I've
re-ordered the patches to put the stable candidates first.

Cheers,

Will

[1] http://lists.linuxfoundation.org/pipermail/iommu/2014-August/009644.html

--->8

The following changes since commit 69e273c0b0a3c337a521d083374c918dc52c666f:

  Linux 3.17-rc3 (2014-08-31 18:23:04 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes

for you to fetch changes up to 4d09d99d543ec28b2280a1f62382697f47ea6366:

  iommu/arm-smmu: fix corner cases in address size calculations (2014-09-02 10:04:43 +0100)

----------------------------------------------------------------
Hans Wennborg (1):
      iommu/arm-smmu: fix decimal printf format specifiers prefixed with 0x

Mitchel Humpherys (1):
      iommu/arm-smmu: avoid calling request_irq in atomic context

Olav Haugan (2):
      iommu/arm-smmu: fix programming of SMMU_CBn_TCR for stage 1
      iommu/arm-smmu: Do not access non-existing S2CR registers

Vladimir Murzin (1):
      iommu/arm-smmu: remove pgtable_page_{c,d}tor()

Will Deacon (2):
      iommu/arm-smmu: fix s2cr and smr teardown on device detach from domain
      iommu/arm-smmu: fix corner cases in address size calculations

 drivers/iommu/arm-smmu.c | 127 +++++++++++++++++++++++++++--------------------
 1 file changed, 73 insertions(+), 54 deletions(-)
