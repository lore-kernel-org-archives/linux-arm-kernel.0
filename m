From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Wed,  3 May 2017 15:17:50 +0100
Subject: [PATCHv2 0/2] kvm: arm/arm64: Fixes for race conditions
Message-ID: <1493821072-29713-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches fixes race conditions in the stage2 page table
handling of the KVM on arm/arm64.

Applies on next-20170503.

Changes since v1:
 http://lists.infradead.org/pipermail/linux-arm-kernel/2017-April/502867.html
 - Dropped patch for fixing mmu_notifier race condition, which couldn't be
   reproduced.
 - Added reviewed-by from Christoffer
 - Added new patch to fix another race condition

Suzuki K Poulose (2):
  kvm: arm/arm64: Fix race in resetting stage2 PGD
  kvm: arm/arm64: Fix use after free of stage2 page table

 arch/arm/kvm/mmu.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

-- 
2.7.4
