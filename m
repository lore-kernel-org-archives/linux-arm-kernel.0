From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 24 Feb 2016 17:33:41 +0000
Subject: [PULL] KVM/ARM fixes for 4.5-rc6
Message-ID: <1456335224-20603-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo,

This is hopefully the last batch of fixes for 4.5. One case of bitmap
going overboard, another case of uninitialized memory, and a fix for
an unpredictable behaviour.

Please pull!

Thanks,

	M.

The following changes since commit 3c5b1d92b3b02be07873d611a27950addff544d3:

  arm64: KVM: Configure TCR_EL2.PS at runtime (2016-02-11 13:16:47 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-4.5-rc6

for you to fetch changes up to fd451b90e78c4178bcfc5072f2b2b637500c109a:

  arm64: KVM: vgic-v3: Restore ICH_APR0Rn_EL2 before ICH_APR1Rn_EL2 (2016-02-24 17:25:58 +0000)

----------------------------------------------------------------
KVM/ARM fixes for 4.5-rc6

- Fix per-vcpu vgic bitmap allocation
- Do not give copy random memory on MMIO read
- Fix GICv3 APR register restore order

----------------------------------------------------------------
Marc Zyngier (2):
      arm/arm64: KVM: Feed initialized memory to MMIO accesses
      arm64: KVM: vgic-v3: Restore ICH_APR0Rn_EL2 before ICH_APR1Rn_EL2

Mark Rutland (1):
      KVM: arm/arm64: vgic: Ensure bitmaps are long enough

 arch/arm/kvm/mmio.c             |  3 ++-
 arch/arm64/kvm/hyp/vgic-v3-sr.c | 20 ++++++++++----------
 virt/kvm/arm/vgic.c             |  4 ++--
 3 files changed, 14 insertions(+), 13 deletions(-)
