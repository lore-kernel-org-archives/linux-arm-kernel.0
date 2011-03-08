From: davidb@codeaurora.org (David Brown)
Date: Tue, 08 Mar 2011 15:43:19 -0800
Subject: [PATCH 1/4] msm: iommu: Clock control for the IOMMU driver
In-Reply-To: <1298599242-21971-1-git-send-email-stepanm@codeaurora.org>
	(Stepan Moskovchenko's message of "Thu, 24 Feb 2011 18:00:39 -0800")
References: <1298599242-21971-1-git-send-email-stepanm@codeaurora.org>
Message-ID: <8yak4g9faaw.fsf@huya.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stepan Moskovchenko (6):
      msm: iommu: Clock control for the IOMMU driver
      msm: iommu: Rework clock logic and add IOMMU bus clock control
      msm: iommu: Use ASID tagging instead of VMID tagging
      msm: iommu: Remove dependency on IDR
      msm: iommu: Don't read from write-only registers
      msm: iommu: Enable HTW L2 redirection on MSM8960

 arch/arm/mach-msm/Kconfig                      |    2 +-
 arch/arm/mach-msm/devices-iommu.c              |   31 ++--
 arch/arm/mach-msm/include/mach/iommu.h         |   18 ++-
 arch/arm/mach-msm/include/mach/iommu_hw-8xxx.h |   32 +---
 arch/arm/mach-msm/iommu.c                      |   72 +++++++--
 arch/arm/mach-msm/iommu_dev.c                  |  230 ++++++++++++++----------
 6 files changed, 232 insertions(+), 153 deletions(-)

I have pulled these changes into my MSM tree, which can be
found at

  git://codeaurora.org/quic/kernel/davidb/linux-msm.git

in the for-next branch

This patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The path will hopefully also be merged in Linus' tree for the next
-rc kernel release.

Thanks,
David

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
