From: anup.patel@linaro.org (Anup Patel)
Date: Thu,  5 Sep 2013 20:15:59 +0530
Subject: [RFC PATCH 0/3] Target CPU=Host implementation for KVM ARM/ARM64
Message-ID: <1378392362-6773-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It will be very useful for user space if it has a method for specifying
KVM ARM/ARM64 to give a VCPU with target type suitable to underlying host 
but with particular set of features.

In other words, user space might not be interested in having a particular
target type for VCPU but it will certainely want particular set of features
in the VCPU.

The patch tries to implement above described method of specifying VCPU
target CPU=Host from user space by extending the KVM_ARM_VCPU_INIT ioctl
and having a dummy target KVM_ARM_TARGET_HOST which means Target CPU
same as (or suitable to) underlying host.

This change in KVM_ARM_VCPU_INIT ioctl is backward compatible to its
current semantics hence does not break user space. The only difference 
is that it will now update the struct kvm_vcpu_init instance (passed 
by user space) with targer type and features of the VCPU that will be 
emulated by KVM ARM/ARM64.

Anup Patel (3):
  ARM: KVM: Implement target CPU=Host
  ARM64: KVM: Implement target CPU=Host
  KVM: ARM: Update documentation for KVM_ARM_VCPU_INIT ioctl

 Documentation/virtual/kvm/api.txt |    5 ++++-
 arch/arm/include/asm/kvm_host.h   |    2 +-
 arch/arm/include/uapi/asm/kvm.h   |    1 +
 arch/arm/kvm/arm.c                |    9 ++++++++-
 arch/arm/kvm/guest.c              |   11 +++++++++--
 arch/arm64/include/asm/kvm_host.h |    2 +-
 arch/arm64/include/uapi/asm/kvm.h |    2 +-
 arch/arm64/kvm/guest.c            |   10 ++++++++--
 8 files changed, 33 insertions(+), 9 deletions(-)

-- 
1.7.9.5
