From: will.deacon@arm.com (Will Deacon)
Date: Fri, 17 Sep 2010 14:12:00 +0100
Subject: [PATCH 0/4] CPU hotplug support for Versatile platforms
Message-ID: <1284729124-15297-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series fixes some issues with the RealView CPU hotplug code and then
factors out the common code into plat-versatile. Finally, support for multiple
tiles is added to the Versatile Express BSP in order to decouple the
tile-specific functions from the motherboard and hotplug support is
added to the ct-ca9x4 tile using the new platform code.

Taken against 2.6.35 and tested on RealView PB11MPCore and Versatile Express
[ct-ca9x4] boards.

Cc: Russell King - ARM Linux <linux@arm.linux.org.uk>

Will Deacon (4):
  ARM: vexpress: add support for multiple core tiles
  ARM: realview: fix CPU hotplug support for SMP platforms
  ARM: plat-versatile: factor out common hotplug code
  ARM: vexpress: add support for CPU hotplug to ct-ca9x4 tile

 arch/arm/mach-realview/hotplug.c                  |   91 +++++++--------------
 arch/arm/mach-vexpress/Makefile                   |    1 +
 arch/arm/mach-vexpress/core.h                     |    5 -
 arch/arm/mach-vexpress/ct-ca9x4.c                 |   91 +++++++++++++++++---
 arch/arm/mach-vexpress/hotplug.c                  |   39 +++++++++
 arch/arm/mach-vexpress/include/mach/ct-ca9x4.h    |    2 +
 arch/arm/mach-vexpress/include/mach/motherboard.h |   26 ++++++
 arch/arm/mach-vexpress/platsmp.c                  |   12 +---
 arch/arm/mach-vexpress/v2m.c                      |   61 +++++++++++---
 arch/arm/plat-versatile/Makefile                  |    1 +
 arch/arm/plat-versatile/hotplug.c                 |   57 +++++++++++++
 arch/arm/plat-versatile/include/plat/hotplug.h    |    6 ++
 12 files changed, 289 insertions(+), 103 deletions(-)
 create mode 100644 arch/arm/mach-vexpress/hotplug.c
 create mode 100644 arch/arm/plat-versatile/hotplug.c
 create mode 100644 arch/arm/plat-versatile/include/plat/hotplug.h
