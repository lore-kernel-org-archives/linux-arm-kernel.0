From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 21 Nov 2014 17:21:04 +0000
Subject: [PULL] arm/arm64: KVM: pull request for 3.18-rc6
Message-ID: <1416590467-6044-1-git-send-email-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo,

Please consider pulling the following patches that fixes a few issues
for KVM on arm/arm64.

The following changes since commit 41e7ed64d86db351a94063596b478a0bfc040258:

  KVM: nVMX: Disable preemption while reading from shadow VMCS (2014-10-29 13:13:52 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-3.18-rc6

for you to fetch changes up to 837711af0e99718af5a8cc84fe42ea335c9c71ce:

  arm/arm64: KVM: vgic: Fix error code in kvm_vgic_create() (2014-11-21 17:00:57 +0000)

----------------------------------------------------------------
Updates for KVM/{arm,arm64}, fixing a few issues:
- fix an unmap error when using 48bit VAs
- trap access to ICC_SRE_EL1 when the guest is trying to use GICv3
- return an error when userspace is trying to init the vgic on a running VM

----------------------------------------------------------------

Christoffer Dall (2):
  arm64: KVM: Handle traps of ICC_SRE_EL1 as RAZ/WI
  arm/arm64: KVM: vgic: Fix error code in kvm_vgic_create()

Mark Rutland (1):
  arm64: KVM: fix unmapping with 48-bit VAs

 arch/arm/kvm/mmu.c        | 3 ++-
 arch/arm64/kvm/sys_regs.c | 9 +++++++++
 virt/kvm/arm/vgic.c       | 8 ++++----
 3 files changed, 15 insertions(+), 5 deletions(-)

-- 
2.1.3
