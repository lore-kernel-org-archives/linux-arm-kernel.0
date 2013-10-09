From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed,  9 Oct 2013 20:49:24 +0200
Subject: [RFC v2 PATCH 0/4] ARM[64]: kernel mode NEON in atomic contexts
Message-ID: <1381344568-14866-1-git-send-email-ard.biesheuvel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is another stab at a way to enable the use of NEON in atomic
context. As suggested by Nico, all there is to it is basically to
stack the registers you are about to use, and unstack them when you're
done.

Patches #1 and #2 implement this for ARM and ARM64 respectively, #3 and #4
are the examples I posted earlier adapted to use this new method.

Ard Biesheuvel (4):
  ARM: add support for kernel mode NEON in atomic context
  ARM64: add support for kernel mode NEON in atomic context
  ARM64: add Crypto Extensions based synchronous core AES cipher
  ARM64: add Crypto Extensions based synchronous AES in CCM mode

 arch/arm/include/asm/fpstate.h        |  15 +-
 arch/arm/include/asm/neon.h           |  34 +++
 arch/arm/vfp/vfphw.S                  |  46 ++++
 arch/arm/vfp/vfpmodule.c              |   3 +
 arch/arm64/crypto/Makefile            |  12 +
 arch/arm64/crypto/aes-sync.c          | 453 ++++++++++++++++++++++++++++++++++
 arch/arm64/crypto/aesce-ccm.S         | 154 ++++++++++++
 arch/arm64/include/asm/fpsimd.h       |  16 ++
 arch/arm64/include/asm/fpsimdmacros.h |  37 +++
 arch/arm64/include/asm/neon.h         |  31 +++
 arch/arm64/kernel/entry-fpsimd.S      |  24 ++
 arch/arm64/kernel/fpsimd.c            |   3 +
 12 files changed, 827 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm64/crypto/Makefile
 create mode 100644 arch/arm64/crypto/aes-sync.c
 create mode 100644 arch/arm64/crypto/aesce-ccm.S

-- 
1.8.1.2
