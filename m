From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Tue, 8 Aug 2017 12:56:31 -0400 (EDT)
Subject: [PULL REQUEST] FDPIC ELF support on ARM
Message-ID: <alpine.LFD.2.20.1708081236150.8927@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, please pull the following:

    http://git.linaro.org/people/nicolas.pitre/linux fdpic

This series provides the needed changes to enable the ELF_FDPIC
binary format on ARM. Currently only no-MMU configs are supported
but eventually adding MMU support is trivial. This format has many
advantages over the FLAT format such as being actual ELF which can be
parsed by standard tools, can support real dynamic shared libs, etc.

This is based on v4.13-rc2.

A complete toolchain and prebuilt packages can be found here:
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
