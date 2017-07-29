From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Fri, 28 Jul 2017 23:51:46 -0400
Subject: [PATCH 0/4] FDPIC support
Message-ID: <20170729035150.5214-1-nicolas.pitre@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This series provides the needed changes to suport the ELF_FDPIC
binary format on no-MMU ARM. This format has many advantages over
the FLAT format such as being actual ELF which can be parsed by
standard tools, can support shared dynamic libs without fuss, etc.

A complete toolchain and prebuilt packages can be found from here:
https://github.com/mickael-guene/fdpic_manifest

diffstat:

 arch/arm/include/asm/elf.h         | 16 ++++++++++++++--
 arch/arm/include/asm/mmu.h         |  4 ++++
 arch/arm/include/asm/processor.h   | 17 +++++++++--------
 arch/arm/include/uapi/asm/ptrace.h |  4 ++++
 arch/arm/include/uapi/asm/unistd.h |  1 +
 arch/arm/kernel/elf.c              |  2 +-
 arch/arm/kernel/signal.c           | 28 ++++++++++++++++++++++++++++
 arch/arm/kernel/sigreturn_codes.S  | 22 ++++++++++++++++++++++
 arch/arm/kernel/traps.c            |  3 +++
 fs/Kconfig.binfmt                  |  2 +-
 10 files changed, 87 insertions(+), 12 deletions(-)
