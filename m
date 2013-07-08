From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 8 Jul 2013 23:23:11 +0100
Subject: [GIT PULL] ARM: kernel mode NEON support
Message-ID: <CAKv+Gu_0XXdCw4-V6LLHCiaH4Wc+=4DTzP6gwgV_h-Qb90gYTA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit 8bb495e3f02401ee6f76d1b1d77f3ac9f079e376:

  Linux 3.10 (2013-06-30 15:13:29 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ardbiesheuvel/linux-arm.git for-rmk

for you to fetch changes up to 7d11965ddb9b9b1e0a5d13c58345ada1ccbc663b:

  lib/raid6: add ARM-NEON accelerated syndrome calculation (2013-07-08
22:09:18 +0100)

----------------------------------------------------------------
Ard Biesheuvel (5):
      ARM: move VFP init to an earlier boot stage
      ARM: be strict about FP exceptions in kernel mode
      ARM: add support for kernel mode NEON
      ARM: crypto: add NEON accelerated XOR implementation
      lib/raid6: add ARM-NEON accelerated syndrome calculation

 arch/arm/Kconfig            |  7 +++++++
 arch/arm/include/asm/neon.h | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/xor.h  | 73
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/lib/Makefile       |  6 ++++++
 arch/arm/lib/xor-neon.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/vfp/vfphw.S        |  5 +++++
 arch/arm/vfp/vfpmodule.c    | 69
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/raid/pq.h     |  5 +++++
 lib/raid6/.gitignore        |  1 +
 lib/raid6/Makefile          | 40 ++++++++++++++++++++++++++++++++++++++++
 lib/raid6/algos.c           |  6 ++++++
 lib/raid6/neon.c            | 58
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/raid6/neon.uc           | 80
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/raid6/test/Makefile     | 26 +++++++++++++++++++++++++-
 14 files changed, 452 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/neon.h
 create mode 100644 arch/arm/lib/xor-neon.c
 create mode 100644 lib/raid6/neon.c
 create mode 100644 lib/raid6/neon.uc
