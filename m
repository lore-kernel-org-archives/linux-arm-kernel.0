From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Aug 2010 16:58:01 +0100
Subject: [PATCH 0/3] CPU hotplug support for Versatile platforms
Message-ID: <1282060684-27761-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes some issues with the RealView CPU hotplug code and then
factors out the common code into plat-versatile. Finally, hotplug support is
added to mach-vexpress using the new platform code.

Taken against 2.6.35 and tested on RealView PB11MPCore and Versatile Express
[ct-ca9x4] boards.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>

Will Deacon (3):
  ARM: realview: fix CPU hotplug support for SMP platforms
  ARM: plat-versatile: factor out common hotplug code
  ARM: vexpress: add support for CPU hotplug to ct-ca9x4 tile

 arch/arm/mach-realview/hotplug.c               |   89 +++++++-----------------
 arch/arm/mach-vexpress/Makefile                |    1 +
 arch/arm/mach-vexpress/ct-ca9x4.c              |   43 +++++++++++
 arch/arm/mach-vexpress/hotplug.c               |   58 +++++++++++++++
 arch/arm/plat-versatile/Makefile               |    1 +
 arch/arm/plat-versatile/hotplug.c              |   57 +++++++++++++++
 arch/arm/plat-versatile/include/plat/hotplug.h |    6 ++
 7 files changed, 192 insertions(+), 63 deletions(-)
 create mode 100644 arch/arm/mach-vexpress/hotplug.c
 create mode 100644 arch/arm/plat-versatile/hotplug.c
 create mode 100644 arch/arm/plat-versatile/include/plat/hotplug.h
