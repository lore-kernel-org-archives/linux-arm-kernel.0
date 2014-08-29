From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 29 Aug 2014 11:59:14 +0200
Subject: [GIT PULL 0/2] KVM/ARM Fixes for v3.17-rc3
Message-ID: <1409306356-11170-1-git-send-email-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paolo and Gleb,

The following changes since commit 30d1e0e806e5b2fadc297ba78f2d7afd6ba309cf:

  virt/kvm/assigned-dev.c: Set 'dev->irq_source_id' to '-1' after free it (2014-08-19 15:12:28 +0200)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-v3.17-rc3

for you to fetch changes up to 05e0127f9e362b36aa35f17b1a3d52bca9322a3a:

  arm/arm64: KVM: Complete WFI/WFE instructions (2014-08-29 11:53:53 +0200)

Thanks,
-Christoffer

----------------------------------------------------------------
These fixes fix two issues in KVM for arm/arm64:
 - hyp mode initialization issues on certian boards/bootloader combos.
 - incorrect return address from trapped WFI/WFE instrucitons, which
   breaks non-linux guests.

----------------------------------------------------------------
Christoffer Dall (1):
      arm/arm64: KVM: Complete WFI/WFE instructions

Pranavkumar Sawargaonkar (1):
      ARM/ARM64: KVM: Nuke Hyp-mode tlbs before enabling MMU

 arch/arm/kvm/handle_exit.c   | 2 ++
 arch/arm/kvm/init.S          | 4 ++++
 arch/arm64/kvm/handle_exit.c | 2 ++
 arch/arm64/kvm/hyp-init.S    | 4 ++++
 4 files changed, 12 insertions(+)
