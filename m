From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Thu, 29 Jan 2015 23:37:54 +0100
Subject: [GIT PULL 0/3] Second round of KVM/ARM fixes for 3.19
Message-ID: <1422571077-14576-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo,

Please pull this second round of fixes for KVM/ARM for 3.19.  Hopefully there
is time to get this upstream before the final release of 3.19.

The series fixes the notorious memory corruption issues on APM platforms and
swapping issues on DMA-coherent systems.

The following changes since commit f3747379accba8e95d70cec0eae0582c8c182050:

  KVM: x86: SYSENTER emulation is broken (2015-01-23 13:57:15 +0100)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-fixes-3.19-2

for you to fetch changes up to 0d3e4d4fade6b04e933b11e69e80044f35e9cd60:

  arm/arm64: KVM: Use kernel mapping to perform invalidation on page fault (2015-01-29 23:24:57 +0100)

Thanks,
Christoffer

----------------------------------------------------------------
Marc Zyngier (3):
      arm/arm64: KVM: Use set/way op trapping to track the state of the caches
      arm/arm64: KVM: Invalidate data cache on unmap
      arm/arm64: KVM: Use kernel mapping to perform invalidation on page fault

 arch/arm/include/asm/kvm_emulate.h   |  10 +++
 arch/arm/include/asm/kvm_host.h      |   3 -
 arch/arm/include/asm/kvm_mmu.h       |  77 +++++++++++++---
 arch/arm/kvm/arm.c                   |  10 ---
 arch/arm/kvm/coproc.c                |  70 +++------------
 arch/arm/kvm/coproc.h                |   6 +-
 arch/arm/kvm/coproc_a15.c            |   2 +-
 arch/arm/kvm/coproc_a7.c             |   2 +-
 arch/arm/kvm/mmu.c                   | 164 ++++++++++++++++++++++++++++++-----
 arch/arm/kvm/trace.h                 |  39 +++++++++
 arch/arm64/include/asm/kvm_emulate.h |  10 +++
 arch/arm64/include/asm/kvm_host.h    |   3 -
 arch/arm64/include/asm/kvm_mmu.h     |  34 ++++++--
 arch/arm64/kvm/sys_regs.c            |  75 +++-------------
 14 files changed, 327 insertions(+), 178 deletions(-)
