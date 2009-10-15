From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 15 Oct 2009 13:21:47 +0100
Subject: [PATCH 0/4] RealView patches for 2.6.33
Message-ID: <20091015121927.739.32071.stgit@pc1117.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

These are mostly RealView patches but the 2nd one re-adds the
conditional definition of __virt_to_phys and __phys_to_virt macros. The
PBX memory support requires non-linear virtual to physical translation
because of the huge gap between the memory blocks (more than 1GB).

Thanks.


Catalin Marinas (3):
      RealView: Add default memory configuration
      Revert 75f4aa1 (unconditionally define __virt_to_phys and __phys_to_virt)
      RealView: Add sparsemem support for the RealView PBX platform

Colin Tuckley (1):
      RealView: Remove duplicated #define REALVIEW_SYS_FLAGS* statements


 arch/arm/include/asm/memory.h                |    2 +
 arch/arm/mach-realview/Kconfig               |    8 ++++-
 arch/arm/mach-realview/core.c                |   42 +++++++++++++++++++++++-
 arch/arm/mach-realview/core.h                |    5 +++
 arch/arm/mach-realview/include/mach/memory.h |   46 ++++++++++++++++++++++++++
 arch/arm/mach-realview/platsmp.c             |    5 +--
 arch/arm/mach-realview/realview_eb.c         |    1 +
 arch/arm/mach-realview/realview_pb1176.c     |   13 +++++++
 arch/arm/mach-realview/realview_pb11mp.c     |    1 +
 arch/arm/mach-realview/realview_pba8.c       |    1 +
 arch/arm/mach-realview/realview_pbx.c        |   21 ++++++++++++
 11 files changed, 139 insertions(+), 6 deletions(-)

-- 
Catalin
