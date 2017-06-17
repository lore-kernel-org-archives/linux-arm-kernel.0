From: f.fainelli@gmail.com (Florian Fainelli)
Date: Fri, 16 Jun 2017 17:07:40 -0700
Subject: [PATCH v3 0/4] Generalize fncpy availability
Message-ID: <20170617000744.22158-1-f.fainelli@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This patch series makes ARM's fncpy() implementation more generic (dropping the
Thumb-specifics) and available in an asm-generic header file.

Tested on a Broadcom ARM64 STB platform with code that is written to SRAM.

Changes in v3 (thanks Doug!):
- correct include guard names in asm-generic/fncpy.h to __ASM_FNCPY_H
- utilize Kbuild to provide the fncpy.h header on ARM64

Changes in v2:
- leave the ARM implementation where it is
- make the generic truly generic (no)

This is helpful in making SoC-specific power management code become true drivers
that can be shared between different architectures.

Thanks!

Florian Fainelli (4):
  ARM: fncpy: Rename include guards
  asm-generic: Provide a fncpy() implementation
  arm64: Provide a fncpy implementation
  misc: sram: Allow ARM64 to select SRAM_EXEC

 arch/arm/include/asm/fncpy.h  |  6 +--
 arch/arm64/include/asm/Kbuild |  1 +
 drivers/misc/Kconfig          |  2 +-
 include/asm-generic/fncpy.h   | 93 +++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 98 insertions(+), 4 deletions(-)
 create mode 100644 include/asm-generic/fncpy.h

-- 
2.9.3
