From: robherring2@gmail.com (Rob Herring)
Date: Tue,  6 May 2014 17:58:04 -0500
Subject: [PATCH 0/3] ARM: early ioremap and permanent fixmap 
Message-ID: <1399417087-24772-1-git-send-email-robherring2@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rob Herring <robh@kernel.org>

This is an updated series based on previous work by Mark Salter and Leif 
Lindholm. The last version with the ARM bits is here[1]. I've added 
fixmap permanent mappings support to this series in order to support 
generic earlycon on ARM. This enables early console output before any 
machine hooks run and is configurable on the command line unlike 
earlyprintk.

This is based on the tty-next tree which has the generic earlycon 
support for 3.16. A git tree is available here[2].

Rob

[1] https://lkml.org/lkml/2014/2/12/608
[2] git://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git arm-fixmap


Mark Salter (2):
  arm: use generic fixmap.h
  arm: add early_ioremap support

Rob Herring (1):
  ARM: fixmap early permanent mapping support

 arch/arm/Kconfig                |  14 +++++
 arch/arm/include/asm/Kbuild     |   1 +
 arch/arm/include/asm/fixmap.h   |  51 +++++++++++-------
 arch/arm/include/asm/io.h       |   1 +
 arch/arm/include/asm/mach/map.h |   1 +
 arch/arm/kernel/setup.c         |   2 +
 arch/arm/mm/Makefile            |   2 +
 arch/arm/mm/early_ioremap.c     | 112 ++++++++++++++++++++++++++++++++++++++++
 arch/arm/mm/init.c              |   2 +-
 arch/arm/mm/mmu.c               |   8 +--
 10 files changed, 172 insertions(+), 22 deletions(-)
 create mode 100644 arch/arm/mm/early_ioremap.c

-- 
1.9.1
