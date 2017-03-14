From: suzuki.poulose@arm.com (Suzuki K Poulose)
Date: Tue, 14 Mar 2017 14:52:31 +0000
Subject: [PATCH 0/3]  kvm: arm/arm64: Fixes for use after free problems
Message-ID: <1489503154-20705-1-git-send-email-suzuki.poulose@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains potential fixes for problems reported by [0] & [1].

[0] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/492944.html
[1] http://lists.infradead.org/pipermail/linux-arm-kernel/2017-March/492943.html


Marc Zyngier (2):
  kvm: arm/arm64: Take mmap_sem in stage2_unmap_vm
  kvm: arm/arm64: Take mmap_sem in kvm_arch_prepare_memory_region

Suzuki K Poulose (1):
  kvm: arm/arm64: Fix locking for kvm_free_stage2_pgd

 arch/arm/kvm/mmu.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

-- 
2.7.4
