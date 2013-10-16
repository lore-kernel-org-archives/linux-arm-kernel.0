From: anup.patel@linaro.org (Anup Patel)
Date: Wed, 16 Oct 2013 22:32:29 +0530
Subject: [RFC PATCH 0/5] PSCI system off and reset for KVM ARM/ARM64
Message-ID: <1381942954-22388-1-git-send-email-anup.patel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The Power State and Coordination Interface (PSCI) specification defines
SYSTEM_OFF and SYSTEM_RESET functions for system poweroff and reboot.

This patchset adds:
1. Emulation of PSCI SYSTEM_OFF and SYSTEM_RESET functions in 
   KVM ARM/ARM64 by forwarding them to user space (QEMU or KVMTOOL)
2. System poweroff and reboot using PSCI for ARM/ARM64 kernel

Anup Patel (5):
  ARM/ARM64: KVM: Update user space API header for PSCI emulation
  ARM/ARM64: KVM: Forward PSCI SYSTEM_OFF and SYSTEM_RESET to user
    space
  KVM: Add documentation for KVM_EXIT_PSCI exit reason
  ARM: psci: Add support for system reboot and poweroff
  ARM64: psci: Add support for system reboot and poweroff

 Documentation/virtual/kvm/api.txt |   13 +++++++++
 arch/arm/include/asm/kvm_psci.h   |   25 +++++++++++++++-
 arch/arm/include/uapi/asm/kvm.h   |    2 ++
 arch/arm/kernel/psci.c            |   36 +++++++++++++++++++++++
 arch/arm/kvm/arm.c                |   12 ++++++--
 arch/arm/kvm/handle_exit.c        |   12 ++++++--
 arch/arm/kvm/psci.c               |   57 ++++++++++++++++++++++++++++++++++---
 arch/arm64/include/asm/kvm_psci.h |   25 +++++++++++++++-
 arch/arm64/include/uapi/asm/kvm.h |    2 ++
 arch/arm64/kernel/psci.c          |   36 +++++++++++++++++++++++
 arch/arm64/kvm/handle_exit.c      |   24 ++++++++++++----
 include/uapi/linux/kvm.h          |    7 +++++
 12 files changed, 233 insertions(+), 18 deletions(-)

-- 
1.7.9.5
