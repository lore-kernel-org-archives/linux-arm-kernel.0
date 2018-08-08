From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed,  8 Aug 2018 14:14:57 +0100
Subject: [PATCH 0/4] KVM: arm/arm64: vgic-v3: Group0 SGI support
Message-ID: <20180808131501.584-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Although we now have Group0 support, we still miss support for Group0
SGIs (which amounts to handling ICC_SGI0R_EL1 and ICC_ASGI1R_EL1
traps), and this small series adds such support.

I appreciate this is *very* late for 4.19, I'd like to take it in as
they complement Christoffer's Group0 support, and It'd be annoying to
have something incomplete in 4.19.

Please shout if you spot something that doesn't look quite right.

Thanks,

	M.

Marc Zyngier (4):
  KVM: arm64: Remove non-existent AArch32 ICC_SGI1R encoding
  KVM: arm/arm64: vgic-v3: Add core support for Group0 SGIs
  KVM: arm64: vgic-v3: Add support for ICC_SGI0R_EL1 and ICC_ASGI1R_EL1
    accesses
  KVM: arm: vgic-v3: Add support for ICC_SGI0R and ICC_ASGI1R accesses

 arch/arm/kvm/coproc.c            | 25 ++++++++++++++++++-
 arch/arm64/include/asm/sysreg.h  |  2 ++
 arch/arm64/kvm/sys_regs.c        | 43 +++++++++++++++++++++++++++++---
 include/kvm/arm_vgic.h           |  2 +-
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 16 +++++++++---
 5 files changed, 79 insertions(+), 9 deletions(-)

-- 
2.18.0
