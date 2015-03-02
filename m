From: alex.bennee@linaro.org (=?UTF-8?q?Alex=20Benn=C3=A9e?=)
Date: Mon,  2 Mar 2015 13:28:59 +0000
Subject: [PATCH v2 0/5] KVM ARM64 Migration Fixes
Message-ID: <1425302944-6276-1-git-send-email-alex.bennee@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

An update to the patch posted earlier this week. Result is textually
identical but

  - split out the vgic_queue_irq_to_lr re-factoring
  - merged doc changes into earlier patch
  - added Acked-by tags

Christoffer,

Are you ok with the split?

The branch I've been working with can be found at:

  http://git.linaro.org/people/alex.bennee/linux.git
  branch: migration/kvmarm-fixes-for-4.0-v2

It includes the two patches from the current kvmarm/master branch.

Alex Benn?e (2):
  arm: KVM: export vcpi->pause state via MP_STATE ioctls
  arm: KVM: add a common vgic_queue_irq_to_lr fn

Christoffer Dall (3):
  arm/arm64: KVM: Implement support for unqueueing active IRQs
  arm/arm64: KVM: Fix migration race in the arch timer
  arm/arm64: KVM: Keep elrsr/aisr in sync with software model

 Documentation/virtual/kvm/api.txt |  24 +++-
 arch/arm/kvm/arm.c                |  23 +++-
 include/kvm/arm_arch_timer.h      |   7 ++
 include/kvm/arm_vgic.h            |  16 ++-
 virt/kvm/arm/arch_timer.c         |  45 +++++--
 virt/kvm/arm/vgic-v2-emul.c       |  20 +++-
 virt/kvm/arm/vgic-v2.c            |   8 ++
 virt/kvm/arm/vgic-v3.c            |   8 ++
 virt/kvm/arm/vgic.c               | 245 +++++++++++++++++++++++++++++++-------
 virt/kvm/arm/vgic.h               |   8 ++
 10 files changed, 342 insertions(+), 62 deletions(-)

-- 
2.3.0
