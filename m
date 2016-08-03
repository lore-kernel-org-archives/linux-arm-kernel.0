From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed,  3 Aug 2016 18:13:22 +0200
Subject: [PATCH 0/3] KVM: arm64: vgic-its fixes
Message-ID: <20160803161325.14933-1-christoffer.dall@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here are three small fixes resulting from looking at the pull request of
kvmarm/next into kvm/next.

They basically deal with corner cases in the reference count handling and
atomicity issues.

Christoffer Dall (3):
  KVM: arm64: vgic-its: Handle errors from vgic_add_lpi
  KVM: arm64: vgic-its: Plug race in vgic_put_irq
  KVM: arm64: vgic-its: Make updates to propbaser/pendbaser atomic

 virt/kvm/arm/vgic/vgic-its.c     | 18 ++++++++++++++----
 virt/kvm/arm/vgic/vgic-mmio-v3.c | 10 ++++++++--
 virt/kvm/arm/vgic/vgic.c         | 20 ++++++++++----------
 3 files changed, 32 insertions(+), 16 deletions(-)

-- 
2.9.0
