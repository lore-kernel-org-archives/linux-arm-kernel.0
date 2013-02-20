From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Wed, 20 Feb 2013 21:08:47 +0530
Subject: [PATCH 0/8] ARM: dts: OMAP5: ocp address space and few updates
Message-ID: <1361374735-22018-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Few updates for OMAP5 found during testing OMAP5 DT builds. Couple
of patches were already posted on the list. The series also contains
a patch which adds DMA request, IRQ lines and IO address space 
DT extraction support to hwmod code so that we can get rid of
such information from hwmod data files. It has been tested on OMAP5
and OMAP4 devices.

Rajendra Nayak (1):
  ARM: dts: OMAP5: Specify nonsecure PPI IRQ for arch timer

Santosh Shilimkar (7):
  ARM: dts: omap5-evm: Update available memory to 2032 MB
  ARM: dts: OMAP5: Align the local timer dt node as per the current
    binding code
  ARM: dts: OMAP5: Move the gic node out of ocp space
  ARM: dts: OMAP5: Update the timer and gic nodes for HYP kernel
    support
  ARM: dts: OMAP5: Update keypad reg property
  ARM: OMAP: hwmod: extract module address space from DT blob
  ARM: dts: OMAP5: Add ocp address space for all hwmods

 arch/arm/boot/dts/omap5-evm.dts  |    2 +-
 arch/arm/boot/dts/omap5.dtsi     |  282 +++++++++++++++++++++++++++++++++++---
 arch/arm/mach-omap2/omap_hwmod.c |   31 ++++-
 3 files changed, 293 insertions(+), 22 deletions(-)

-- 
1.7.9.5
