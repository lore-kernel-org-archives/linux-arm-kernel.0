From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 5 Nov 2014 11:54:30 +0100
Subject: [GIT PULL] arm64: UEFI updates for 3.19
Message-ID: <CAKv+Gu8LEFvdu99vCHbHGPmGLpHWdT+Wb2DECzBEEg8g_yynvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

The following changes since commit cac7f2429872d3733dc3f9915857b1691da2eb2f:

  Linux 3.18-rc2 (2014-10-26 16:48:41 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ard.biesheuvel/linux-arm.git tags/for-3.19

for you to fetch changes up to 0bcaa9040d058684d58c36ef273b8946996c7078:

  efi: efi-stub: notify on DTB absence (2014-11-05 09:03:34 +0100)

----------------------------------------------------------------
UEFI updates for arm64

This series consists of:
- fixes for compliance with PE/COFF and UEFI specs
- added support for SMBIOS, including upcoming version 3.0
- cleanups and diagnostic output improvements

----------------------------------------------------------------
Ard Biesheuvel (8):
      arm64/efi: efistub: jump to 'stext' directly, not through the header
      arm64/efi: set PE/COFF section alignment to 4 KB
      arm64/efi: set PE/COFF file alignment to 512 bytes
      arm64/efi: invert UEFI memory region reservation logic
      arm64/efi: drop redundant set_bit(EFI_CONFIG_TABLES)
      efi: dmi: add support for SMBIOS 3.0 UEFI configuration table
      dmi: add support for SMBIOS 3.0 64-bit entry point
      arm64: dmi: set DMI string as dump stack arch description

Mark Rutland (1):
      efi: efi-stub: notify on DTB absence

Yi Li (1):
      arm64: dmi: Add SMBIOS/DMI support

 arch/arm64/Kconfig                      | 11 +++++
 arch/arm64/include/asm/dmi.h            | 31 +++++++++++++
 arch/arm64/kernel/efi-entry.S           |  3 +-
 arch/arm64/kernel/efi.c                 | 37 ++++++++++-----
 arch/arm64/kernel/head.S                | 24 +++++++---
 arch/arm64/kernel/vmlinux.lds.S         | 17 +++++++
 drivers/firmware/dmi_scan.c             | 79 ++++++++++++++++++++++++++++++---
 drivers/firmware/efi/efi.c              |  4 ++
 drivers/firmware/efi/libstub/arm-stub.c | 11 ++++-
 drivers/xen/efi.c                       |  1 +
 include/linux/efi.h                     |  6 ++-
 11 files changed, 195 insertions(+), 29 deletions(-)
 create mode 100644 arch/arm64/include/asm/dmi.h
