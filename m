From: leif.lindholm@linaro.org (Leif Lindholm)
Date: Thu,  3 Oct 2013 12:24:38 +0100
Subject: [PATCH v2 0/3] arm: [U]EFI runtime services support
Message-ID: <1380799481-5470-1-git-send-email-leif.lindholm@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

In systems based on [U]EFI-conformant firmware, runtime services provide
a standardised way for the kernel to update firmware environment
variables. This is used for example by efibootmgr to update which image
should be loaded on next boot.

This patchset implements basic support for UEFI runtime services on ARM
platforms, as well as the basic underlying EFI support. It also defines
a mechanism by which the required information is passed from the
bootloader to the kernel via FDT entries.

This patchset depends on the previously submitted early_ioremap() and
generic UEFI config table scanning patchsets.

Changes from v1:
- Updated FDT bindings, based on feedback.
- Use common config table scanning and address lookup code.
- Add dependency on !CPU_BIG_ENDIAN (for now).
- Add proper efi_enabled() facility.
- Documentation updates.

Leif Lindholm (3):
  Documentation: arm: add UEFI support documentation
  arm: Add [U]EFI runtime services support
  init: efi: arm: enable (U)EFI runtime services on arm

 Documentation/arm/00-INDEX |    3 +
 Documentation/arm/uefi.txt |   47 +++++
 arch/arm/Kconfig           |   15 ++
 arch/arm/include/asm/efi.h |   22 ++
 arch/arm/kernel/Makefile   |    2 +
 arch/arm/kernel/efi.c      |  485 ++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/kernel/efi_phys.S |   59 ++++++
 arch/arm/kernel/setup.c    |    6 +
 include/linux/efi.h        |    2 +-
 init/main.c                |    4 +
 10 files changed, 644 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/arm/uefi.txt
 create mode 100644 arch/arm/include/asm/efi.h
 create mode 100644 arch/arm/kernel/efi.c
 create mode 100644 arch/arm/kernel/efi_phys.S

-- 
1.7.10.4
