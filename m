From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu,  1 Dec 2016 09:25:40 +0000
Subject: [PULL] KVM/ARM updates for 4.9-rc7
Message-ID: <1480584341-32340-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Paolo, Radim,

Hopefully, this is the last update for 4.9. This time, a single patch
that prevents bogus acknoledgement of interrupts.

It'd be great if this could make it into v4.9-final

Thanks,

	M.

The following changes since commit b112c84a6ff035271d41d548c10215f18443d6a6:

  KVM: arm64: Fix the issues when guest PMCCFILTR is configured (2016-11-18 09:06:58 +0000)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-4.9-rc7

for you to fetch changes up to 8ca18eec2b2276b449c1dc86b98bf083c5fe4e09:

  KVM: arm/arm64: vgic: Don't notify EOI for non-SPIs (2016-11-24 13:12:07 +0000)

----------------------------------------------------------------
KVM/ARM updates for v4.9-rc7

- Do not call kvm_notify_acked for PPIs

----------------------------------------------------------------
Marc Zyngier (1):
      KVM: arm/arm64: vgic: Don't notify EOI for non-SPIs

 virt/kvm/arm/vgic/vgic-v2.c | 6 ++++--
 virt/kvm/arm/vgic/vgic-v3.c | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)
