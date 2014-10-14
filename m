From: atull@opensource.altera.com (atull at opensource.altera.com)
Date: Tue, 14 Oct 2014 14:33:37 -0500
Subject: [PATCH v3 0/2] socfpga: fix hotplug/add suspend to ram
Message-ID: <1413315219-28885-1-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alan Tull <atull@opensource.altera.com>

Patch 1: socfpga: hotplug: put cpu1 in wfi
  Use WFI when putting CPU1 to sleep.  Don't hold CPU1 in reset
  since that results in increased power consumption.  Only
  briefly reset CPU1.

Patch 2: socfpga: support suspend to ram
  * allocate space in ocram using sram driver
  * Add a function in ocram to do suspend to ram and
    place DDR in self-refresh

Alan Tull (2):
  socfpga: hotplug: put cpu1 in wfi
  socfpga: support suspend to ram

 arch/arm/mach-socfpga/Kconfig        |    1 +
 arch/arm/mach-socfpga/Makefile       |    1 +
 arch/arm/mach-socfpga/core.h         |    7 ++
 arch/arm/mach-socfpga/platsmp.c      |   19 ++--
 arch/arm/mach-socfpga/pm.c           |  150 ++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/self-refresh.S |  157 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c      |   10 +++
 7 files changed, 337 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/pm.c
 create mode 100644 arch/arm/mach-socfpga/self-refresh.S

-- 
1.7.9.5
