From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  6 Oct 2016 11:27:24 +0100
Subject: [PATCH 0/2] efi: add support for seeding the kernel RNG from UEFI
Message-ID: <1475749646-10844-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements generic EFI core kernel code to seed the kernel entropy
pool from a Linux specific UEFI configuration table containing a random seed
supplied by the firmware. (#1)

In addition, it wires it up for ARM and arm64, by invoking the EFI_RNG_PROTOCOL
UEFI protocol from the stub, and populating such a UEFI config table using its
output.

How to wire this up for x86 is left as an exercise for the Intel developer.

Ard Biesheuvel (2):
  efi: add support for seeding the RNG from a UEFI config table
  efi/arm*: libstub: invoke EFI_RNG_PROTOCOL to seed the UEFI RNG table

 drivers/firmware/efi/efi.c              | 26 +++++++++++
 drivers/firmware/efi/libstub/arm-stub.c |  2 +
 drivers/firmware/efi/libstub/efistub.h  |  2 +
 drivers/firmware/efi/libstub/random.c   | 48 ++++++++++++++++++++
 include/linux/efi.h                     |  9 ++++
 5 files changed, 87 insertions(+)

-- 
2.7.4
