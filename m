From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri,  6 Mar 2015 15:34:38 +0100
Subject: [PATCH roundup 0/4] extend VA range of ID map for core kernel and KVM
Message-ID: <1425652482-31411-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are the VA range patches presented as a coherent set. The bounce page
and 'HYP init code too big' error are probably not prerequisites anymore now
that I switched from merging the HYP runtime map with the HYP id map rather
than the kernel ID map, but I would strongly prefer to keep it as a single
series.

Ard Biesheuvel (3):
  arm64: mm: increase VA range of identity map
  ARM, arm64: kvm: get rid of the bounce page
  arm64: KVM: use ID map with increased VA range if required

Arnd Bergmann (1):
  ARM: KVM: avoid "HYP init code too big" error

 arch/arm/include/asm/kvm_mmu.h         | 10 +++++
 arch/arm/kernel/vmlinux.lds.S          | 35 ++++++++++++++---
 arch/arm/kvm/init.S                    |  3 ++
 arch/arm/kvm/mmu.c                     | 69 +++++++++++++++-------------------
 arch/arm64/include/asm/kvm_mmu.h       | 33 ++++++++++++++++
 arch/arm64/include/asm/mmu_context.h   | 43 +++++++++++++++++++++
 arch/arm64/include/asm/page.h          |  6 ++-
 arch/arm64/include/asm/pgtable-hwdef.h |  7 +++-
 arch/arm64/kernel/head.S               | 38 +++++++++++++++++++
 arch/arm64/kernel/smp.c                |  1 +
 arch/arm64/kernel/vmlinux.lds.S        | 18 ++++++---
 arch/arm64/kvm/hyp-init.S              | 26 +++++++++++++
 arch/arm64/mm/mmu.c                    |  7 +++-
 arch/arm64/mm/proc-macros.S            | 11 ++++++
 arch/arm64/mm/proc.S                   |  3 ++
 15 files changed, 256 insertions(+), 54 deletions(-)

-- 
1.8.3.2
