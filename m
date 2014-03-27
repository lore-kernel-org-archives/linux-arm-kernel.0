From: ashwin.chaugule@linaro.org (Ashwin Chaugule)
Date: Thu, 27 Mar 2014 17:23:47 -0400
Subject: [PATCH v3 0/3] PSCI v0.2 support and DT bindings
Message-ID: <1395955430-26050-1-git-send-email-ashwin.chaugule@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset adds some new functions introduced by the PSCI v0.2 spec.
It also adds DT bindings to differentiate between PSCI v0.1 and v0.2 and
appropriately selects the Function IDs. The third patch makes use of a
new function, AFFINITY_INFO, added by PSCI v0.2 to ensure that CPU's
killed after CPU_OFF are actually offlined.

Changes in v3:
        -       Roll up common functionality for getting conduit method.
        -       Remove #defines for ARM32 and ARM64 in uapi/linux/psci.h
        -       Remove functions not supported by PSCI v0.1
        -       Misc cleanups.
        -       Add PSCI_AFFINITY_INFO return types in uapi header.
        -       Changed function names for PSCI v0.1 and PSCI v0.2
        -       Added copyright info to uapi header.
        -       Fixed args to affinity_info call.
        -       Fix typo in psci_init definition when PSCI is not defined.

Changes in v2:

        -       Add AFFINITY_INFO and MIGRATE_INFO_TYPE functions.
        -       Add binding Documentation.
        -       Add function to get PSCI version.
        -       Add common #defines in uapi/linux/psci.h
        -       Implement cpu_kill and check if CPU is dead via AFFINITY_INFO.
        -       Misc cleanups.

Changes in v1:

        -       Add new binding "arm, psci-0.2"
        -       Separate conduit and PSCI function assignment methods.


Ashwin Chaugule (3):
  PSCI: Add initial support for PSCIv0.2 functions
  Documentation: devicetree: Add new binding for PSCIv0.2
  ARM: Check if a CPU has gone offline

 Documentation/devicetree/bindings/arm/psci.txt |  35 +++++-
 arch/arm/include/asm/psci.h                    |   7 +-
 arch/arm/kernel/psci.c                         | 151 ++++++++++++++++++++----
 arch/arm/kernel/psci_smp.c                     |  21 ++++
 arch/arm64/kernel/psci.c                       | 154 +++++++++++++++++++++----
 include/uapi/linux/psci.h                      |  45 ++++++++
 6 files changed, 367 insertions(+), 46 deletions(-)
 create mode 100644 include/uapi/linux/psci.h

-- 
1.8.3.2
