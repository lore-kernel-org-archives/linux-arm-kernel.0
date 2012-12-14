From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Fri, 14 Dec 2012 17:45:24 +0100
Subject: [PATCH 0/7] ARM: mackerel: extended DT support
Message-ID: <1355503531-7276-1-git-send-email-g.liakhovetski@gmx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The purpose of this patch set is to continue mackerel migration to DT 
booting, while preserving the ability to boot without a DT image. Further 
devices will be migrated from platform data to DT as their drivers become 
ready for such migration.

Guennadi Liakhovetski (7):
  ARM: sh7372: add missing "#interrupt-cells" properties
  ARM: mackerel: include the correct .dtsi file
  ARM: sh7372: support mixed DT and board code interrupt controller
    init
  ARM: sh7372: add clock lookup entries for DT-based devices
  ARM: sh7372: allow boards supporting booting with or without DT
  ARM: mackerel: support booting with or without DT
  ARM: mackerel: add more devices to DT

 arch/arm/boot/dts/sh7372-mackerel.dts   |   98 ++++++++++++++++++++++++++++++-
 arch/arm/boot/dts/sh7372.dtsi           |    2 +
 arch/arm/mach-shmobile/board-mackerel.c |   84 +++++++++++++++++++++------
 arch/arm/mach-shmobile/clock-sh7372.c   |    9 +++
 arch/arm/mach-shmobile/intc-sh7372.c    |    6 ++
 arch/arm/mach-shmobile/setup-sh7372.c   |   17 +++++-
 6 files changed, 194 insertions(+), 22 deletions(-)

-- 
1.7.2.5

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
