From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Wed, 14 May 2014 12:49:52 -0700
Subject: [GIT PULL] arm64: crypto patches
Message-ID: <CAKv+Gu_yP8p77S8LiZ3RBetCtUcZqw3k3CGK05dvCZG_naF_Ng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ard.biesheuvel/linux-arm.git arm64-crypto

for you to fetch changes up to 4b000d55804baf07b26a14d7bf0df85947a253ee:

  arm64/crypto: add voluntary preemption to Crypto Extensions GHASH
(2014-05-14 10:51:24 -0700)

----------------------------------------------------------------
Ard Biesheuvel (15):
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
      arm64/crypto: add shared macro to test for NEED_RESCHED
      arm64/crypto: add voluntary preemption to Crypto Extensions SHA1
      arm64/crypto: add voluntary preemption to Crypto Extensions SHA2
      arm64/crypto: add voluntary preemption to Crypto Extensions GHASH

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
 arch/arm64/crypto/ghash-ce-core.S     |  97 +++++++
 arch/arm64/crypto/ghash-ce-glue.c     | 173 +++++++++++
 arch/arm64/crypto/sha1-ce-core.S      | 154 ++++++++++
 arch/arm64/crypto/sha1-ce-glue.c      | 190 ++++++++++++
 arch/arm64/crypto/sha2-ce-core.S      | 159 ++++++++++
 arch/arm64/crypto/sha2-ce-glue.c      | 270 +++++++++++++++++
 arch/arm64/include/asm/Kbuild         |   1 +
 arch/arm64/include/asm/assembler.h    |  21 ++
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
 31 files changed, 3611 insertions(+), 43 deletions(-)
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
