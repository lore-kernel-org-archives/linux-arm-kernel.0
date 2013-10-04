From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri,  4 Oct 2013 17:13:19 +0100
Subject: [PATCH v3 0/2] KVM/ARM Huge pages support
Message-ID: <1380903201-32644-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This small series adds support for Transparent Huge Pages and hugetlbfs
pages for KVM on the arm and arm64 architectures.

Measurements have shown that using huge pages in for stage-2 mappings
provides up to more than 15% performance increase for some workloads.

The patch series applies to kvm/next, but depends on the patch sent
earlier:
http://marc.info/?l=kvm&m=138074894126934&w=2

The whole thing can also be cloned from here:
git://git.linaro.org/people/cdall/linux-kvm-arm.git kvm-arm-hugepages-v3

See the patches for changelogs.

Christoffer Dall (2):
  KVM: ARM: Support hugetlbfs backed huge pages
  KVM: ARM: Transparent huge page (THP) support

 arch/arm/include/asm/kvm_mmu.h         |  17 ++-
 arch/arm/include/asm/pgtable-3level.h  |   2 +
 arch/arm/kvm/mmu.c                     | 223 +++++++++++++++++++++++++++------
 arch/arm64/include/asm/kvm_mmu.h       |  12 +-
 arch/arm64/include/asm/pgtable-hwdef.h |   2 +
 5 files changed, 212 insertions(+), 44 deletions(-)

-- 
1.8.1.2
