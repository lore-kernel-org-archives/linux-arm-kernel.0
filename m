From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 29 Jun 2010 23:55:02 -0400 (EDT)
Subject: Git pull request: some security features missing on ARM
Message-ID: <alpine.LFD.2.00.1006292342210.24097@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell, could you pull the following for the next merge window:

	git://git.linaro.org/nico/arm_security

This contains a few security features that are present on x86 and 
missing on ARM.  Those patches were posted on the list a while ago and 
no objections came back.

Nicolas Pitre (4):
      [ARM] implement arch_randomize_brk()
      [ARM] add address randomization to mmap()
      ARM: initial stack protector (-fstack-protector) support
      ARM: stack protector: change the canary value per task

 arch/arm/Kconfig                      |   12 ++++++++
 arch/arm/Makefile                     |    4 +++
 arch/arm/include/asm/elf.h            |    3 ++
 arch/arm/include/asm/stackprotector.h |   38 +++++++++++++++++++++++++++
 arch/arm/kernel/asm-offsets.c         |    3 ++
 arch/arm/kernel/entry-armv.S          |    8 +++++
 arch/arm/kernel/process.c             |   13 +++++++++
 arch/arm/mm/mmap.c                    |    4 +++
 8 files changed, 85 insertions(+), 0 deletions(-)
