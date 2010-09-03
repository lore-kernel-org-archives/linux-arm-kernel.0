From: sundar.iyer@stericsson.com (Sundar Iyer)
Date: Fri, 3 Sep 2010 17:31:04 +0530
Subject: [PATCH 0/2] ARM: factorise CPU hotplug code
Message-ID: <1283515266-25374-1-git-send-email-sundar.iyer@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Inspired by Will Deacon's cleanup for the Realview series, this is an attempt
to factor even more common code and move hotplug functions to the generic
arch/arm/common folder

Sundar Iyer (2):
  ARM: Generalize all CPU Hotplug code across platforms
  ux500: Add CPU hotplug support

 arch/arm/common/Makefile           |    1 +
 arch/arm/common/hotplug.c          |   57 ++++++++++++++++++++++++++++++++++++
 arch/arm/include/asm/hotplug.h     |   18 +++++++++++
 arch/arm/mach-omap2/omap-hotplug.c |   24 +--------------
 arch/arm/mach-realview/hotplug.c   |   56 ++++-------------------------------
 arch/arm/mach-s5pv310/hotplug.c    |   56 ++++-------------------------------
 arch/arm/mach-tegra/hotplug.c      |   56 +++++------------------------------
 arch/arm/mach-ux500/Makefile       |    1 +
 arch/arm/mach-ux500/hotplug.c      |   30 +++++++++++++++++++
 arch/arm/mach-ux500/platsmp.c      |    4 ++-
 10 files changed, 134 insertions(+), 169 deletions(-)
 create mode 100644 arch/arm/common/hotplug.c
 create mode 100644 arch/arm/include/asm/hotplug.h
 create mode 100644 arch/arm/mach-ux500/hotplug.c

-- 
1.7.2.dirty
