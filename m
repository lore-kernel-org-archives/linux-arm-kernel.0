From: suravee.suthikulpanit@amd.com (suravee.suthikulpanit at amd.com)
Date: Mon, 15 Sep 2014 19:47:22 -0500
Subject: [RFC PATCH for AMD Seattle 0/4] Drivers for AMD-Seatlle to boot from
 ACPI
Message-ID: <1410828446-28502-1-git-send-email-suravee.suthikulpanit@amd.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>

As a follow up of the email thread:

    [PATCH v3 00/17] Introduce ACPI for ARM64 based on ACPI 5.1
    https://lkml.org/lkml/2014/9/1/446

Besides Hanjun Guo's patches above, these are the additional patches required
to boot AMD Seattle platform with full ACPI support:

    [PATCH] efi/arm64: efistub: don't abort if base of DRAM is occupied
    http://lists.infradead.org/pipermail/linux-arm-kernel/2014-July/272274.html

    [PATCH v2] efi/arm64: fix fdt-related memory reservation
    https://lkml.org/lkml/2014/9/8/483

    [PATCH] ata: ahci_platform: Add ACPI support for AMD Seattle SATA controller
    https://lkml.org/lkml/2014/9/9/834

    [RFC PATCH for Juno 2/2] tty: SBSA compatible UART
    https://lkml.org/lkml/2014/9/1/448
    (NOTE: This is not meant to be submitted upstream, but required to enable
     ACPI support for UART SBSA driver.)

These patches are rebased from the linux-3.17-rc4 upstream kernel, and 
compatible with the AMD Seattle Firmware version ROD0070C.
The full kernel boot log can be found here:

    http://people.linaro.org/~al.stone/seattle-boot-acpi-dmesg.txt

Suravee / Al

Ard Biesheuvel (1):
  arm64/efi: efistub: don't abort if base of DRAM is occupied

Grame Gregory (1):
  [RFC PATCH for Juno 2/2] tty: SBSA compatible UART

Mark Salter (1):
  efi/arm64: fix fdt-related memory reservation

Suravee Suthikulpanit (1):
  ata: ahci_platform: Add ACPI support for AMD Seattle SATA controller

 arch/arm64/kernel/efi-stub.c       |  16 +-
 arch/arm64/mm/init.c               |   3 +-
 drivers/ata/Kconfig                |   2 +-
 drivers/ata/ahci_platform.c        |  13 ++
 drivers/firmware/efi/libstub/fdt.c |  10 +-
 drivers/tty/Kconfig                |   6 +
 drivers/tty/Makefile               |   1 +
 drivers/tty/sbsauart.c             | 328 +++++++++++++++++++++++++++++++++++++
 8 files changed, 365 insertions(+), 14 deletions(-)
 create mode 100644 drivers/tty/sbsauart.c

-- 
1.9.3
