From: colin.tuckley@arm.com (Colin Tuckley)
Date: Fri, 07 Oct 2011 15:27:17 +0100
Subject: [PATCH 0/5 v4] ARM Realview PCIX patch series
Message-ID: <20111007142310.19554.17204.stgit@e102602-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a resend of patches that were posted before with various
comments addressed and rebased to 3.1.0-rc9.

The following series implements adding PCI
support to the ARM Realview family of boards.

---

Colin Tuckley (5):
      ARM Realview PCIX build file changes
      Realview PCIX support - add main support module code
      ARM Realview PCIX board file changes
      ARM Realview PCIX IRQ include file changes
      ARM Realview PCIX map include file changes


 arch/arm/Kconfig                                   |    3 
 arch/arm/mach-realview/Makefile                    |    5 
 arch/arm/mach-realview/include/mach/board-pb11mp.h |   11 
 arch/arm/mach-realview/include/mach/board-pba8.h   |   11 
 arch/arm/mach-realview/include/mach/board-pbx.h    |   11 
 arch/arm/mach-realview/include/mach/hardware.h     |   22 +
 arch/arm/mach-realview/include/mach/io.h           |    8 
 arch/arm/mach-realview/include/mach/irqs-pb11mp.h  |   11 
 arch/arm/mach-realview/include/mach/irqs-pba8.h    |    7 
 arch/arm/mach-realview/include/mach/irqs-pbx.h     |    7 
 arch/arm/mach-realview/include/mach/platform.h     |   15 -
 arch/arm/mach-realview/pcix.c                      |  472 ++++++++++++++++++++
 arch/arm/mach-realview/realview_pb11mp.c           |   18 +
 arch/arm/mach-realview/realview_pba8.c             |   18 +
 arch/arm/mach-realview/realview_pbx.c              |   16 +
 15 files changed, 577 insertions(+), 58 deletions(-)
 create mode 100755 arch/arm/mach-realview/pcix.c

-- 
