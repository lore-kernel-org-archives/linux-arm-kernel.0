From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 19 Oct 2016 12:40:30 +0100
Subject: [RFC PATCH 0/2] efi/arm64: add vmlinux link to PE/COFF debug table
Message-ID: <1476877232-24308-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Much like GNU debug links, PE/COFF binaries can carry the patch to the binary
containing the debugging symbols. Since the kernel binary is loaded by UEFI
at an a priori unknown offset in the 1:1 mapping of physical memory, having
this information is useful for the debugger automation to find the file and
the offset, and load the symbols automatically.

So if we have debugging symbols to begin with (CONFIG_DEBUG_INFO=y), add the
absolute path to vmlinux to the PE/COFF debug table.

Ard Biesheuvel (2):
  efi: libstub: preserve .debug sections after absolute relocation check
  efi: arm64: add vmlinux debug link to the Image binary

 arch/arm64/kernel/Makefile            |  4 +++
 arch/arm64/kernel/head.S              | 34 +++++++++++++++++++-
 arch/arm64/kernel/image.h             |  3 ++
 drivers/firmware/efi/libstub/Makefile | 19 ++++++++---
 4 files changed, 54 insertions(+), 6 deletions(-)

-- 
2.7.4
