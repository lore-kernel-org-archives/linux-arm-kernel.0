From: anup.patel@linaro.org (Anup Patel)
Date: Wed, 11 Sep 2013 18:29:51 +0530
Subject: [PATCH 0/2] Target CPU=Host implementation for KVM ARM/ARM64
Message-ID: <1378904393-29101-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

It will be very useful for user space if it has a method of querying
VCPU target type suitable to underlying Host. We can use such querying
mechanism and implement machine models in user space where VCPU target
type is always same-as/suitable-to underlying Host (i.e. Target CPU=Host).

This patch series implements KVM_ARM_SUITABLE_TARGET ioclt for querying
VCPU target type matching underlying host. Using this new ioctl we can
implement VCPU target CPU=Host in user space (i.e. QEMU/KVMTOOL).

Also, it is not mandatory to call KVM_ARM_SUITABLE_TARGET ioctl and the 
old method of using only KVM_ARM_VCPU_INIT ioctl works fine.

Anup Patel (2):
  ARM/ARM64: KVM: Implement KVM_ARM_SUITABLE_TARGET ioctl
  KVM: Add documentation for KVM_ARM_SUITABLE_TARGET ioctl

 Documentation/virtual/kvm/api.txt |   25 ++++++++++++++++++++-----
 arch/arm/kvm/arm.c                |    2 ++
 include/uapi/linux/kvm.h          |    1 +
 3 files changed, 23 insertions(+), 5 deletions(-)

-- 
1.7.9.5
