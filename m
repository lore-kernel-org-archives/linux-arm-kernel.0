From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 04 Nov 2009 16:25:38 +0000
Subject: [GIT PULL] RealView and ARMv7 patches for 2.6.33
Message-ID: <1257351938.26524.117.camel@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

Could you please pull the branch below for the upcoming merging window?

There are two patches for checking whether the SCU and the SMP/nAMP
modes are already initialised (if running in non-secure mode) which were
posted on the list but haven't got any comments (they are trivial
anyway).

Thanks.


The following changes since commit b419148e567728f6af0c3b01965c1cc141e3e13a:
  Linus Torvalds (1):
        Linux 2.6.32-rc6

are available in the git repository at:

  git://linux-arm.org/linux-2.6.git for-rmk

Catalin Marinas (3):
      Check whether the SCU was already initialised
      RealView: Add default memory configuration
      RealView: Add sparsemem support for the RealView PBX platform

Colin Tuckley (1):
      RealView: Remove duplicated #define REALVIEW_SYS_FLAGS* statements

Tony Thompson (1):
      ARMv7: Check whether the SMP/nAMP mode was already enabled

 arch/arm/kernel/smp_scu.c                    |    4 ++
 arch/arm/mach-realview/Kconfig               |    8 ++++-
 arch/arm/mach-realview/core.c                |   42 +++++++++++++++++++++-
 arch/arm/mach-realview/core.h                |    6 +++
 arch/arm/mach-realview/include/mach/memory.h |   49 ++++++++++++++++++++++++++
 arch/arm/mach-realview/platsmp.c             |    5 +--
 arch/arm/mach-realview/realview_eb.c         |    1 +
 arch/arm/mach-realview/realview_pb1176.c     |   13 +++++++
 arch/arm/mach-realview/realview_pb11mp.c     |    1 +
 arch/arm/mach-realview/realview_pba8.c       |    1 +
 arch/arm/mach-realview/realview_pbx.c        |   21 +++++++++++
 arch/arm/mm/proc-v7.S                        |    7 ++--
 12 files changed, 149 insertions(+), 9 deletions(-)

-- 
Catalin
