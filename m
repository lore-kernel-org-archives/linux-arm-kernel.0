From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Mon, 24 Jun 2013 17:26:26 +0200
Subject: [GIT PULL] support for kernel mode NEON
Message-ID: <CAKv+Gu8Ms2oV_qQj6OLeP_FQ4kMhzJmjn0a+RDqsG2iRx97zOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ardbiesheuvel/linux-arm.git for-rmk

for you to fetch changes up to 81de811871661eff2b97cd9abfed9952d6aeb68c:

  lib/raid6: add ARM-NEON accelerated syndrome calculation (2013-06-24
17:20:51 +0200)

----------------------------------------------------------------
Ard Biesheuvel (5):
      ARM: add support for kernel mode NEON
      ARM: move VFP init to an earlier boot stage
      ARM: be strict about FP exceptions in kernel mode
      ARM: crypto: add NEON accelerated XOR implementation
      lib/raid6: add ARM-NEON accelerated syndrome calculation

 arch/arm/Kconfig            |  7 +++++++
 arch/arm/include/asm/neon.h | 36 ++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/xor.h  | 73
+++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/lib/Makefile       |  6 ++++++
 arch/arm/lib/xor-neon.c     | 42 ++++++++++++++++++++++++++++++++++++++++++
 arch/arm/vfp/vfphw.S        |  5 +++++
 arch/arm/vfp/vfpmodule.c    | 56
+++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 include/linux/raid/pq.h     |  5 +++++
 lib/raid6/.gitignore        |  1 +
 lib/raid6/Makefile          | 40 ++++++++++++++++++++++++++++++++++++++++
 lib/raid6/algos.c           |  6 ++++++
 lib/raid6/neon.c            | 58
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/raid6/neon.uc           | 80
++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lib/raid6/test/Makefile     | 19 ++++++++++++++++++-
 14 files changed, 432 insertions(+), 2 deletions(-)
 create mode 100644 arch/arm/include/asm/neon.h
 create mode 100644 arch/arm/lib/xor-neon.c
 create mode 100644 lib/raid6/neon.c
 create mode 100644 lib/raid6/neon.uc
