From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu,  8 Aug 2013 21:07:16 -0700
Subject: [PATCH 0/3] KVM/ARM Huge pages support
Message-ID: <1376021239-10532-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series adds support for Transparent Huge Pages and hugetlbfs
pages for KVM on the arm and arm64 architectures.

Measurements have shown that using huge pages in for stage-2 mappings
provides up to more than 15% performance increase for some workloads.

The patch series applies to kvm/next, but depends on the patch sent
earlier:

"ARM: KVM: Fix unaligned unmap_range leak"

Christoffer Dall (3):
  KVM: Move gfn_to_index to x86 specific code
  KVM: ARM: Get rid of KVM_HPAGE_XXX defines
  KVM: ARM: Transparent huge pages and hugetlbfs support

 arch/arm/include/asm/kvm_host.h  |    5 -
 arch/arm/include/asm/kvm_mmu.h   |   17 +++-
 arch/arm/kvm/mmu.c               |  200 ++++++++++++++++++++++++++++++++------
 arch/arm64/include/asm/kvm_mmu.h |   12 ++-
 arch/x86/include/asm/kvm_host.h  |    7 ++
 include/linux/kvm_host.h         |    7 --
 6 files changed, 201 insertions(+), 47 deletions(-)

-- 
1.7.10.4
