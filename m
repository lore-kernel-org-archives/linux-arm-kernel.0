From: kristina.martsenko@arm.com (Kristina Martsenko)
Date: Mon, 15 Jan 2018 15:23:47 +0000
Subject: [PATCH 0/3] Fixes for 52-bit physical address patches
Message-ID: <1516029830-12326-1-git-send-email-kristina.martsenko@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin/Will,

Here are a couple of fixes to the 52-bit physical address patch series.
Some bugs were introduced in the last version (v2) of the series, which
has now been merged to arm64/for-next/core. The first two patches in
this series put things back as they were in the previous version (v1) of
the series. The third patch fixes a comment. These issues have been
discussed in the email thread of v2 of the series.

Thanks,
Kristina


Kristina Martsenko (3):
  arm64: fix ID map extension to 52 bits
  KVM: arm/arm64: fix HYP ID map extension to 52 bits
  arm64: fix comment above tcr_compute_pa_size

 arch/arm64/include/asm/assembler.h   |  2 +-
 arch/arm64/include/asm/mmu_context.h |  5 ++---
 virt/kvm/arm/mmu.c                   | 18 ++++++------------
 3 files changed, 9 insertions(+), 16 deletions(-)

-- 
2.1.4
