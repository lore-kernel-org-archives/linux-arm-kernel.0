From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Thu, 15 May 2014 15:35:09 -0700
Subject: [GIT PULL v2] arm64: crypto patches
Message-ID: <CAKv+Gu9G2GSznzsnLOeR9fgvcEb2+teVhHb8mOwti8YNcZVhOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ard.biesheuvel/linux-arm.git tags/for-3.16

for you to fetch changes up to 49788fe2a128217f78a21ee4edbe6e92e988f222:

  arm64/crypto: AES-ECB/CBC/CTR/XTS using ARMv8 NEON and Crypto
Extensions (2014-05-14 10:04:16 -0700)

----------------------------------------------------------------
Ard Biesheuvel (11):
      asm-generic: allow generic unaligned access if the arch supports it
      arm64: add abstractions for FPSIMD state manipulation
      arm64: defer reloading a task's FPSIMD state to userland resume
      arm64: add support for kernel mode NEON in interrupt context
      arm64/crypto: SHA-1 using ARMv8 Crypto Extensions
      arm64/crypto: SHA-224/SHA-256 using ARMv8 Crypto Extensions
      arm64/crypto: GHASH secure hash using ARMv8 Crypto Extensions
      arm64/crypto: AES using ARMv8 Crypto Extensions
      arm64/crypto: AES in CCM mode using ARMv8 Crypto Extensions
      arm64: pull in <asm/simd.h> from asm-generic
      arm64/crypto: AES-ECB/CBC/CTR/XTS using ARMv8 NEON and Crypto Extensions

 arch/arm64/Kconfig                    |   3 +
 arch/arm64/Makefile                   |   1 +
 arch/arm64/crypto/Kconfig             |  53 ++++
 arch/arm64/crypto/Makefile            |  38 +++
 arch/arm64/crypto/aes-ce-ccm-core.S   | 222 ++++++++++++++
 arch/arm64/crypto/aes-ce-ccm-glue.c   | 297 +++++++++++++++++++
 arch/arm64/crypto/aes-ce-cipher.c     | 155 ++++++++++
 arch/arm64/crypto/aes-ce.S            | 133 +++++++++
 arch/arm64/crypto/aes-glue.c          | 446 ++++++++++++++++++++++++++++
 arch/arm64/crypto/aes-modes.S         | 532 ++++++++++++++++++++++++++++++++++
 arch/arm64/crypto/aes-neon.S          | 382 ++++++++++++++++++++++++
 arch/arm64/crypto/ghash-ce-core.S     |  95 ++++++
 arch/arm64/crypto/ghash-ce-glue.c     | 155 ++++++++++
 arch/arm64/crypto/sha1-ce-core.S      | 153 ++++++++++
 arch/arm64/crypto/sha1-ce-glue.c      | 174 +++++++++++
 arch/arm64/crypto/sha2-ce-core.S      | 156 ++++++++++
 arch/arm64/crypto/sha2-ce-glue.c      | 255 ++++++++++++++++
 arch/arm64/include/asm/Kbuild         |   1 +
 arch/arm64/include/asm/fpsimd.h       |  23 ++
 arch/arm64/include/asm/fpsimdmacros.h |  35 +++
 arch/arm64/include/asm/neon.h         |   6 +-
 arch/arm64/include/asm/thread_info.h  |   4 +-
 arch/arm64/kernel/entry-fpsimd.S      |  24 ++
 arch/arm64/kernel/entry.S             |   2 +-
 arch/arm64/kernel/fpsimd.c            | 186 ++++++++++--
 arch/arm64/kernel/process.c           |   2 +-
 arch/arm64/kernel/ptrace.c            |   2 +
 arch/arm64/kernel/signal.c            |  13 +-
 arch/arm64/kernel/signal32.c          |   9 +-
 include/asm-generic/unaligned.h       |  21 +-
 30 files changed, 3535 insertions(+), 43 deletions(-)
 create mode 100644 arch/arm64/crypto/Kconfig
 create mode 100644 arch/arm64/crypto/Makefile
 create mode 100644 arch/arm64/crypto/aes-ce-ccm-core.S
 create mode 100644 arch/arm64/crypto/aes-ce-ccm-glue.c
 create mode 100644 arch/arm64/crypto/aes-ce-cipher.c
 create mode 100644 arch/arm64/crypto/aes-ce.S
 create mode 100644 arch/arm64/crypto/aes-glue.c
 create mode 100644 arch/arm64/crypto/aes-modes.S
 create mode 100644 arch/arm64/crypto/aes-neon.S
 create mode 100644 arch/arm64/crypto/ghash-ce-core.S
 create mode 100644 arch/arm64/crypto/ghash-ce-glue.c
 create mode 100644 arch/arm64/crypto/sha1-ce-core.S
 create mode 100644 arch/arm64/crypto/sha1-ce-glue.c
 create mode 100644 arch/arm64/crypto/sha2-ce-core.S
 create mode 100644 arch/arm64/crypto/sha2-ce-glue.c
