From: stepanm@codeaurora.org (Stepan Moskovchenko)
Date: Fri, 19 Nov 2010 19:02:31 -0800
Subject: [PATCH 0/3] msm: iommu: Further improvements to the MSM IOMMU driver
Message-ID: <1290222154-11096-1-git-send-email-stepanm@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This depends on the clock control driver. Please hold off
on this until the clock driver is in.

Simplify the IOMMU clock control, probe functions, and
initialization, since we no longer have to work around
having a dummy clock driver. As a result, all the IOMMU
devices can now be safely be probed and initialized. Also
add clock control for the IOMMU bus interconnect, which is
only needed for access to IOMMU registers and now can be
disabled for most of the time.

Stepan Moskovchenko (3):
  msm: iommu: Add bus clocks to platform data
  msm: iommu: Clock control for the IOMMU driver
  msm: iommu: Simplify the platform clock code

 arch/arm/mach-msm/devices-msm8x60-iommu.c |    5 -
 arch/arm/mach-msm/include/mach/iommu.h    |   12 +-
 arch/arm/mach-msm/iommu.c                 |   82 ++++++++++--
 arch/arm/mach-msm/iommu_dev.c             |  204 +++++++++++++++++------------
 4 files changed, 196 insertions(+), 107 deletions(-)

Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
