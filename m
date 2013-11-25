From: yi.li@linaro.org (Yi Li)
Date: Tue, 26 Nov 2013 00:44:23 +0800
Subject: [PATCH 0/3] *** Support SMBIOS/DMI on arm32/64 ***
Message-ID: <1385397866-7524-1-git-send-email-yi.li@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The patches support SMBIOS/DMI on arm system, it tested by dmidecode
and lshw tools.

The first patch is wrapping remap/unmap methond for general archs,
and has been posted for review to x86 and ia64, waiting the ack.
The last two patches depend on booting from UEFI and SMBIOS data 
reported as Runtime Services Data type.

Ard Biesheuvel (1):
  firmware/dmi_scan: generalize for use by other archs

Yi Li (2):
  ARM64:DMI: Add smbios/dmi support on arm64
  ARM32:DMI: Add smbios/dmi support on arm32

 arch/arm/Kconfig             |   13 +++++++++++++
 arch/arm/include/asm/dmi.h   |   28 ++++++++++++++++++++++++++++
 arch/arm/kernel/setup.c      |    2 ++
 arch/arm64/Kconfig           |   10 ++++++++++
 arch/arm64/include/asm/dmi.h |   28 ++++++++++++++++++++++++++++
 arch/arm64/kernel/setup.c    |    2 ++
 arch/ia64/include/asm/dmi.h  |   10 +++++++---
 arch/x86/include/asm/dmi.h   |    8 ++++++--
 drivers/firmware/dmi_scan.c  |   20 +++++++++++---------
 9 files changed, 107 insertions(+), 14 deletions(-)
 create mode 100644 arch/arm/include/asm/dmi.h
 create mode 100644 arch/arm64/include/asm/dmi.h

-- 
1.7.9.5
