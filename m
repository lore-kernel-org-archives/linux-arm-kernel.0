From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 11 Jun 2013 18:10:27 +0200
Subject: [GIT PULL] support for kernel mode NEON
Message-ID: <CAKv+Gu_jf6xq+EPFucCPxLjNKY-O3bv2GtXb=PLd8TL9Rg5eBg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

If you feel the remaining issues with these patches have been
addressed, please find my pull request below.
Note that the RAID-6 syndrome calculation patch is not included here:
the code lives under linux/lib/raid6/ so I will propose it on the LKML
instead.

Regards,
Ard.


The following changes since commit e4aa937ec75df0eea0bee03bffa3303ad36c986b:

  Linux 3.10-rc3 (2013-05-26 16:00:47 -0700)

are available in the git repository at:

  git://git.linaro.org/people/ardbiesheuvel/linux-arm.git for-rmk

for you to fetch changes up to 35af08a00df3bd0261921e62bcfbdf9558fcbfc7:

  ARM: crypto: add NEON accelerated XOR implementation (2013-06-11
17:51:05 +0200)

----------------------------------------------------------------
Ard Biesheuvel (4):
      ARM: add support for kernel mode NEON
      ARM: move VFP init to an earlier boot stage
      ARM: be strict about FP exceptions in kernel mode
      ARM: crypto: add NEON accelerated XOR implementation

 arch/arm/Kconfig            |  7 +++++
 arch/arm/include/asm/neon.h | 36 ++++++++++++++++++++++
 arch/arm/include/asm/xor.h  | 73 +++++++++++++++++++++++++++++++++++++++++++++
 arch/arm/lib/Makefile       |  6 ++++
 arch/arm/lib/xor-neon.c     | 42 ++++++++++++++++++++++++++
 arch/arm/vfp/vfphw.S        |  5 ++++
 arch/arm/vfp/vfpmodule.c    | 56 +++++++++++++++++++++++++++++++++-
 7 files changed, 224 insertions(+), 1 deletion(-)
 create mode 100644 arch/arm/include/asm/neon.h
 create mode 100644 arch/arm/lib/xor-neon.c
