From: c.dall@virtualopensystems.com (Christoffer Dall)
Date: Wed, 09 Jan 2013 11:26:03 -0500
Subject: [PATCH v5.1 0/2] KVM: ARM: Rename KVM_SET_DEVICE_ADDRESS
In-Reply-To: <20130108184116.46558.3558.stgit@ubuntu>
References: <20130108184116.46558.3558.stgit@ubuntu>
Message-ID: <20130109162554.12103.38937.stgit@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Renames the KVM_SET_DEVICE_ADDRESS to KVM_ARM_SET_DEVICE_ADDR
to make it obvious that this is ARM specific in lack of a better generic
interface.

Once we agree on a better interface the KVM/ARM code can also take
advantage of that, but until then we don't want to hold up the KVM/ARM
patches.

A new complete series of these patches including this change can be
pulled from:
  git://github.com/virtualopensystems/linux-kvm-arm.git
  kvm-arm-v15-devaddr-v2

-Christoffer

---

Christoffer Dall (2):
      KVM: ARM: Introduce KVM_SET_DEVICE_ADDRESS ioctl
      ARM: KVM: VGIC accept vcpu and dist base addresses from user space


 Documentation/virtual/kvm/api.txt   |   38 ++++++
 arch/arm/include/asm/hardware/gic.h |   25 ++++
 arch/arm/include/asm/kvm_host.h     |   18 +++
 arch/arm/include/asm/kvm_vgic.h     |   89 +++++++++++++++
 arch/arm/include/uapi/asm/kvm.h     |   16 +++
 arch/arm/kvm/Makefile               |    1 
 arch/arm/kvm/arm.c                  |   92 +++++++++++++++-
 arch/arm/kvm/interrupts.S           |    4 +
 arch/arm/kvm/mmio.c                 |    3 +
 arch/arm/kvm/vgic.c                 |  206 +++++++++++++++++++++++++++++++++++
 include/uapi/linux/kvm.h            |    8 +
 11 files changed, 498 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/kvm_vgic.h
 create mode 100644 arch/arm/kvm/vgic.c

-- 
