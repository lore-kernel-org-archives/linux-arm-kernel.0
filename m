From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Jul 2013 14:53:51 +0100
Subject: [PATCH 0/4] KVM/arm64 fixes for 3.11
Message-ID: <1374242035-13199-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series contains a small number of patches for KVM/arm64. The
first two are the arm64 equivalent of AArch32 fixes that have already
been merged, and the next two are more related to performance
optimisation and code cleanup.

The patches are also available at:
git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git kvm-arm64/fixes-3.11-rc1

Marc Zyngier (4):
  arm64: KVM: perform save/restore of PAR_EL1
  arm64: KVM: add missing dsb before invalidating Stage-2 TLBs
  arm64: KVM: let other tasks run when hitting WFE
  arm64: KVM: remove __kvm_hyp_code_{start,end} from hyp.S

 arch/arm64/include/asm/kvm_arm.h |  6 ++++--
 arch/arm64/include/asm/kvm_asm.h | 23 ++++++++++++++---------
 arch/arm64/include/asm/virt.h    |  4 ++++
 arch/arm64/kvm/handle_exit.c     | 18 +++++++++++++-----
 arch/arm64/kvm/hyp.S             | 18 ++++++++++++------
 arch/arm64/kvm/sys_regs.c        |  3 +++
 6 files changed, 50 insertions(+), 22 deletions(-)

-- 
1.8.2.3
