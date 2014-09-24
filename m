From: atull@opensource.altera.com (atull at opensource.altera.com)
Date: Wed, 24 Sep 2014 15:27:27 -0500
Subject: [PATCH 0/2] socfpga: fix hotplug/add suspend to ram
Message-ID: <1411590449-9794-1-git-send-email-atull@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alan Tull <atull@opensource.altera.com>

patch 1: socfpga: hotplug: put cpu1 in wfi
  Fix how cpu1 is hotplugged to prevent increaced power
  consumption.

patch 2: socfpga: support suspend to ram
  * Initialize ocram
  * Add a function to do suspend to ram and
    place DDR in self-refresh
  * This function lives in ocram

Alan Tull (2):
  socfpga: hotplug: put cpu1 in wfi
  socfpga: support suspend to ram

 arch/arm/mach-socfpga/Makefile       |    1 +
 arch/arm/mach-socfpga/core.h         |    6 ++
 arch/arm/mach-socfpga/platsmp.c      |   12 ++-
 arch/arm/mach-socfpga/pm.c           |  141 ++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/self-refresh.S |  148 ++++++++++++++++++++++++++++++++++
 arch/arm/mach-socfpga/socfpga.c      |   10 +++
 6 files changed, 315 insertions(+), 3 deletions(-)
 create mode 100644 arch/arm/mach-socfpga/pm.c
 create mode 100644 arch/arm/mach-socfpga/self-refresh.S

-- 
1.7.9.5
