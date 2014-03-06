From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu,  6 Mar 2014 12:12:46 +0800
Subject: [PATCH 0/2] arm64: SHA1 using ARM v8 Crypto Extensions 
Message-ID: <1394079168-27666-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This implements the SHA1 hash using ARM v8 Crypto Instructions.

Note that these patches depend on the modalias patch and NEON optimization
patches posted to the list over the past weeks. 

The first patch is included for reference *only*. It implements emulation of
the SHA1 instructions in the kernel. (You need this patch to test the code if
your emulator or hardware has no support for Crypto Extensions)

Ard Biesheuvel (2):
  arm64: add kernel emulation for AES and SHA1 instructions
  arm64: Add support for SHA1 using ARMv8 Crypto Extensions

 arch/arm64/Makefile              |   1 +
 arch/arm64/crypto/Makefile       |   2 +
 arch/arm64/crypto/sha1-ce-core.S | 121 +++++++++++
 arch/arm64/crypto/sha1-ce-glue.c | 149 ++++++++++++++
 arch/arm64/emu/Makefile          |  11 +
 arch/arm64/emu/ce-emu.c          | 430 +++++++++++++++++++++++++++++++++++++++
 arch/arm64/include/asm/traps.h   |  10 +
 arch/arm64/kernel/entry.S        |   4 +-
 arch/arm64/kernel/traps.c        |  49 +++++
 crypto/Kconfig                   |   6 +
 10 files changed, 782 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/crypto/sha1-ce-core.S
 create mode 100644 arch/arm64/crypto/sha1-ce-glue.c
 create mode 100644 arch/arm64/emu/Makefile
 create mode 100644 arch/arm64/emu/ce-emu.c

-- 
1.8.3.2
