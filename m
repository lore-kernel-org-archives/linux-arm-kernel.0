From: anup.patel@linaro.org (Anup Patel)
Date: Tue, 21 Jan 2014 18:31:38 +0530
Subject: [RFC PATCH 0/3] In-kernel PSCI v0.2 emulation for KVM ARM/ARM64
Message-ID: <1390309301-28424-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently, KVM ARM/ARM64 only provides in-kernel emulation of Power State
and Coordination Interface (PSCI) v0.1.

This patchset aims at providing newer PSCI v0.2 for KVM ARM/ARM64 VCPUs
such that it does not break current KVM ARM/ARM64 ABI. Also, the patchset
provides emulation of only few PSCI v0.2 functions such as PSCI_VERSION,
CPU_ON, and CPU_OFF. Emulation of other PSCI v0.2 functions will be added
later.

The user space tools (i.e. QEMU or KVMTOOL) will have to explicitly enable
KVM_ARM_VCPU_PSCI_0_2 feature using KVM_ARM_VCPU_INIT ioctl for providing
PSCI v0.2 to VCPUs. 

Anup Patel (3):
  KVM: Add capability to advertise PSCI v0.2 support
  ARM/ARM64: KVM: Add support for PSCI v0.2 emulation
  KVM: Documentation: Add info regarding KVM_ARM_VCPU_PSCI_0_2 feature

 Documentation/virtual/kvm/api.txt |    2 +
 arch/arm/include/asm/kvm_host.h   |    2 +-
 arch/arm/include/uapi/asm/kvm.h   |   39 ++++++++++++++++--
 arch/arm/kvm/arm.c                |    6 ++-
 arch/arm/kvm/psci.c               |   79 ++++++++++++++++++++++++++++++-------
 arch/arm64/include/asm/kvm_host.h |    2 +-
 arch/arm64/include/uapi/asm/kvm.h |   39 ++++++++++++++++--
 include/uapi/linux/kvm.h          |    1 +
 8 files changed, 146 insertions(+), 24 deletions(-)

-- 
1.7.9.5
