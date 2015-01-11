From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 11 Jan 2015 14:10:09 +0100
Subject: [GIT PULL 0/2] KVM/ARM Fixes for 3.19
Message-ID: <1420981811-18731-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo,

The following changes since commit b1940cd21c0f4abdce101253e860feff547291b0:

  Linux 3.19-rc3 (2015-01-05 17:05:20 -0800)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-fixes-3.19

for you to fetch changes up to b5b8ddba844c6b6c5b96c27b284d9ed05a16fa13:

  arm64: KVM: Fix HCR setting for 32bit guests (2015-01-11 13:54:51 +0100)

(Note that I got an extra merge commit when merging kvm/master into
kvmarm/master, which I think is because Linus applied the set of fixes
from kvmarm/master directly from Marc's patches. Let me know if you need
me to mangle this differently somehow.)

Thanks,
-Christoffer

----------------------------------------------------------------
Fixes for KVM/ARM for 3.19 addressing TLB invalidation issues and 32-bit guest
regression.

----------------------------------------------------------------
Marc Zyngier (2):
      arm64: KVM: Fix TLB invalidation by IPA/VMID
      arm64: KVM: Fix HCR setting for 32bit guests

 arch/arm64/include/asm/kvm_emulate.h | 2 ++
 arch/arm64/kvm/hyp.S                 | 1 +
 arch/arm64/kvm/reset.c               | 1 -
 3 files changed, 3 insertions(+), 1 deletion(-)
