From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Tue, 30 Sep 2014 18:28:11 -0700
Subject: [PATCH v4 0/2] iommu/arm-smmu: hard iova_to_phys
Message-ID: <1412126893-15796-1-git-send-email-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces support for performing iova-to-phys translations via
the ARM SMMU hardware on supported implementations. We also make use of
some new generic macros for polling hardware registers.

v1..v2:

  - Renamed one of the iopoll macros to use the more standard `_atomic'
    suffix
  - Removed some convenience iopoll wrappers to encourage explicitness

v2..v3:

  - Removed unnecessary `dev_name's

v3..v4:

  - Updated the iopoll commit message to reflect the patch better
  - Added locking around address translation op
  - Return 0 on iova_to_phys failure


Matt Wagantall (1):
  iopoll: Introduce memory-mapped IO polling macros

Mitchel Humpherys (1):
  iommu/arm-smmu: add support for iova_to_phys through ATS1PR

 drivers/iommu/arm-smmu.c | 79 +++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/iopoll.h   | 77 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 155 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/iopoll.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
