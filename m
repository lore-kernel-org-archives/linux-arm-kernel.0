From: will.deacon@arm.com (Will Deacon)
Date: Fri, 18 Aug 2017 16:19:48 +0100
Subject: [GIT PULL] iommu/arm-smmu: Updates for 4.14
Message-ID: <20170818151947.GB7900@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Joerg,

It's been a quiet cycle on the SMMU front, but please pull these three
patches for 4.14. They're all in relation to power management and device
shutdown, which allows us to handle suspend/resume and kexec operations
gracefully.

Cheers,

Will

--->8

The following changes since commit aae4e7a8bc44722fe70d58920a36916b1043195e:

  Linux 4.13-rc4 (2017-08-06 18:44:49 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/will/linux.git for-joerg/arm-smmu/updates

for you to fetch changes up to a2d866f7d66574d980a2e4544bc626e29bb33365:

  iommu/arm-smmu: Add system PM support (2017-08-16 17:27:29 +0100)

----------------------------------------------------------------
Nate Watterson (1):
      iommu/arm-smmu-v3: Implement shutdown method

Robin Murphy (2):
      iommu/arm-smmu: Track context bank state
      iommu/arm-smmu: Add system PM support

 drivers/iommu/arm-smmu-v3.c |   7 ++
 drivers/iommu/arm-smmu.c    | 173 +++++++++++++++++++++++++++++---------------
 2 files changed, 121 insertions(+), 59 deletions(-)
