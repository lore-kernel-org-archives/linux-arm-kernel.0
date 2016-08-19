From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Aug 2016 17:02:31 +0100
Subject: [GIT PULL] iommu/arm-smmu: Fixes for 4.8
Message-ID: <20160819160231.GH9893@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

As promised yesterday, here are a few ARM SMMU fixes for 4.8. I've added
a Fixes: line to each patch, so they should be good to go. The main changes
are:

  - Fix a couple of thinkos in the CMDQ error handling and short-descriptor
    page table code that have been there since day one
  - Disable stalling faults, since they may result in hardware deadlock
  - Fix an accidental BUG() when passing disable_bypass=1 on the cmdline

Cheers,

Will

--->8

The following changes since commit 694d0d0bb2030d2e36df73e2d23d5770511dbc8d:

  Linux 4.8-rc2 (2016-08-14 19:11:36 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/fixes

for you to fetch changes up to 5bc0a11664e17e9f9551983f5b660bd48b57483c:

  iommu/arm-smmu: Don't BUG() if we find aborting STEs with disable_bypass (2016-08-19 09:48:15 +0100)

----------------------------------------------------------------
Robin Murphy (1):
      iommu/io-pgtable-arm-v7s: Fix attributes when splitting blocks

Will Deacon (3):
      iommu/arm-smmu: Fix CMDQ error handling
      iommu/arm-smmu: Disable stalling faults for all endpoints
      iommu/arm-smmu: Don't BUG() if we find aborting STEs with disable_bypass

 drivers/iommu/arm-smmu-v3.c        |  7 +++++--
 drivers/iommu/arm-smmu.c           | 34 +++++++---------------------------
 drivers/iommu/io-pgtable-arm-v7s.c |  4 +++-
 3 files changed, 15 insertions(+), 30 deletions(-)
