From: marc.zyngier@arm.com (Marc Zyngier)
Date: Wed, 25 Feb 2015 16:55:37 +0000
Subject: [PATCH 0/3] arm64: KVM: High memory guest fixes
Message-ID: <1424883340-29940-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I've been playing with a hacked-up kvmtool that places the memory much
higher than usual, in an effort to emulate what some arm64 platforms
do (typically AMD Seattle).

Unexpectedly (hey, what could possibly go wrong...), I've discovered a
couple of mm related issues, ranging from the host exploding to the
guest being stuck on a page fault. Additionally, I noticed a minor
documentation issue.

With these fixes in, I'm able to run a guest that has its memory
located just under the 40bit limit.

Marc Zyngier (3):
  arm64: KVM: Fix stage-2 PGD allocation to have per-page refcounting
  arm64: KVM: Do not use pgd_index to index stage-2 pgd
  arm64: KVM: Fix outdated comment about VTCR_EL2.PS

 arch/arm/include/asm/kvm_mmu.h   | 10 +++++++++-
 arch/arm/kvm/mmu.c               | 10 +++++-----
 arch/arm64/include/asm/kvm_arm.h |  5 +++--
 arch/arm64/include/asm/kvm_mmu.h | 11 ++++++++++-
 4 files changed, 27 insertions(+), 9 deletions(-)

-- 
2.1.4
