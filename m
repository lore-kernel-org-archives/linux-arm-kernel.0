From: gengdongjiu@huawei.com (Dongjiu Geng)
Date: Tue, 5 Jun 2018 03:45:40 +0800
Subject: [PATCH v2 0/2] support to set VSESR_EL2 by user space
Message-ID: <1528141542-44048-1-git-send-email-gengdongjiu@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series patch is separated from https://www.spinics.net/lists/kvm/msg168917.html

1. Detect whether KVM can set set guest SError syndrome
2. Support to Set VSESR_EL2 and inject SError by user space.
3. Support live migration to keep SError pending state and VSESR_EL2 value

The user space patch is here: https://lists.gnu.org/archive/html/qemu-devel/2018-05/msg06965.html

Dongjiu Geng (2):
  arm64: KVM: export the capability to set guest SError syndrome
  arm/arm64: KVM: Add KVM_GET/SET_VCPU_EVENTS

 Documentation/virtual/kvm/api.txt    | 42 +++++++++++++++++++++++++++++++++---
 arch/arm/include/asm/kvm_host.h      |  6 ++++++
 arch/arm/kvm/guest.c                 | 12 +++++++++++
 arch/arm64/include/asm/kvm_emulate.h |  5 +++++
 arch/arm64/include/asm/kvm_host.h    |  7 ++++++
 arch/arm64/include/uapi/asm/kvm.h    | 13 +++++++++++
 arch/arm64/kvm/guest.c               | 35 ++++++++++++++++++++++++++++++
 arch/arm64/kvm/inject_fault.c        |  6 +++---
 arch/arm64/kvm/reset.c               |  4 ++++
 include/uapi/linux/kvm.h             |  1 +
 virt/kvm/arm/arm.c                   | 19 ++++++++++++++++
 11 files changed, 144 insertions(+), 6 deletions(-)

-- 
2.7.4
