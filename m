From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Thu, 11 Sep 2014 11:30:42 -0700
Subject: [PATCH 0/2] iommu/arm-smmu: hard iova_to_phys
Message-ID: <1410460244-18943-1-git-send-email-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces support for performing iova-to-phys translations via
the ARM SMMU hardware on supported implementations. We also make use of
some new generic macros for polling hardware registers.

The iopoll macros were previously discussed here:
http://marc.info/?l=linux-arm-kernel&m=140414727509158


Matt Wagantall (1):
  iopoll: Introduce memory-mapped IO polling macros

Mitchel Humpherys (1):
  iommu/arm-smmu: add support for iova_to_phys through ATS1PR

 drivers/iommu/arm-smmu.c |  73 +++++++++++++++++++++++++++++-
 include/linux/iopoll.h   | 114 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 186 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/iopoll.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
