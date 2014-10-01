From: atull@opensource.altera.com (atull at opensource.altera.com)
Date: Wed, 1 Oct 2014 14:38:22 -0500
Subject: [PATCH v2 0/2] socfpga: fix hotplug/add suspend to ram
Message-ID: <1412192304-1209-1-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alan Tull <atull@opensource.altera.com>

Patch 1: socfpga: hotplug: put cpu1 in wfi
  Fix how cpu1 is hotplugged to prevent increased power
  consumption.

v2: no need to flush the caches
    clean up spacing in comments
    replace a register offset with a macro

Patch 2: socfpga: support suspend to ram
  * allocate space in ocram
  * Add a function to do suspend to ram and
    place DDR in self-refresh
  * This function lives in ocram

v2: use Generic on-chip SRAM driver to allocate ocram
    rm fncpy_align since generic allocator handles alignment
    check __arm_ioremap_exec return code
    check for NULL pointers
    add a comment regarding sdram controller configuration

Alan Tull (2):
  socfpga: hotplug: put cpu1 in wfi
  socfpga: support suspend to ram

 arch/arm/mach-socfpga/Kconfig        |    1 +
 arch/arm/mach-socfpga/Makefile       |    1 +
 arch/arm/mach-socfpga/core.h         |    7 ++
 arch/arm/mach-socfpga/platsmp.c      |   16 ++--
 arch/arm/mach-socfpga/pm.c           |  147 +++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/self-refresh.S |  157 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c      |   10 +++
 7 files changed, 333 insertions(+), 6 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/pm.c
 create mode 100644 arch/arm/mach-socfpga/self-refresh.S

-- 
1.7.9.5
