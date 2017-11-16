From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 16 Nov 2017 17:58:14 +0000
Subject: [PATCH 0/7] KVM/ARM fixes for 4.15-rc1
Message-ID: <20171116175821.26544-1-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

Here's a handful of KVM/ARM fixes I've collected over the week:

- Four bugs reported by AKASHI Takahiro who ran the SMATCH static
  analyser on the KVM/ARM code. All great findings! I've split the
  fixes so that they can be backported individually.
- A nice corner case found by Kristina Martsenko on arm64 (which she
  posted separately), which  actually originated from the 32bit port
  (and I've now included a patch plugging that one as well).
- One GICv4 leftover.

I've stashed all of that on my kvm-arm64/fixes-4.15 branch.

Thanks,

	M.

Kristina Martsenko (1):
  arm64: KVM: fix VTTBR_BADDR_MASK BUG_ON off-by-one

Marc Zyngier (6):
  KVM: arm/arm64: vgic-irqfd: Fix MSI entry allocation
  KVM: arm/arm64: vgic: Preserve the revious read from the pending table
  KVM: arm/arm64: vgic-its: Preserve the revious read from the pending
    table
  KVM: arm/arm64: vgic-its: Check result of allocation before use
  KVM: arm/arm64: vgic-v4: Only perform an unmap for valid vLPIs
  arm: KVM: Fix VTTBR_BADDR_MASK BUG_ON off-by-one

 arch/arm/include/asm/kvm_arm.h   | 3 +--
 arch/arm64/include/asm/kvm_arm.h | 3 +--
 virt/kvm/arm/vgic/vgic-irqfd.c   | 3 +--
 virt/kvm/arm/vgic/vgic-its.c     | 4 +++-
 virt/kvm/arm/vgic/vgic-v3.c      | 2 +-
 virt/kvm/arm/vgic/vgic-v4.c      | 6 ++++--
 6 files changed, 11 insertions(+), 10 deletions(-)

-- 
2.14.2
