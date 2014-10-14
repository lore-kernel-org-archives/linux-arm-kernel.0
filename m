From: mitchelh@codeaurora.org (Mitchel Humpherys)
Date: Tue, 14 Oct 2014 14:53:28 -0700
Subject: [PATCH v6 0/2] iommu/arm-smmu: hard iova_to_phys
Message-ID: <1413323610-27484-1-git-send-email-mitchelh@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series introduces support for performing iova-to-phys translations via
the ARM SMMU hardware on supported implementations. We also make use of
some new generic macros for polling hardware registers.

v5..v6:

  - iopoll: use shift instead of divide
  - arm-smmu: no changes, resending series due to iopoll change.

v4..v5:

  - iopoll: Added support for other accessor functions
  - iopoll: Unified atomic and non-atomic interfaces
  - iopoll: Fixed erroneous `might_sleep'
  - arm-smmu: Lowered timeout and moved to new iopoll atomic interface

v3..v4:

  - Updated the iopoll commit message to reflect the patch better
  - Added locking around address translation op
  - Return 0 on iova_to_phys failure

v2..v3:

  - Removed unnecessary `dev_name's

v1..v2:

  - Renamed one of the iopoll macros to use the more standard `_atomic'
    suffix
  - Removed some convenience iopoll wrappers to encourage explicitness


Matt Wagantall (1):
  iopoll: Introduce memory-mapped IO polling macros

Mitchel Humpherys (1):
  iommu/arm-smmu: add support for iova_to_phys through ATS1PR

 drivers/iommu/arm-smmu.c |  79 +++++++++++++++++-
 include/linux/iopoll.h   | 213 +++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 291 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/iopoll.h

-- 
Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
