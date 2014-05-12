From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 12 May 2014 12:38:18 -0400
Subject: No subject
Message-ID: <1399912699-29446-1-git-send-email-santosh.shilimkar@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>From 14f3791439b5a6cf12127fb80204265533d92664 Mon Sep 17 00:00:00 2001
From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Date: Mon, 12 May 2014 12:28:23 -0400
Subject: [GIT PULL 1/2] ARM: Keystone SOC updates for 3.16

Hi Arm-soc folks,

Please pull below keystone SOC updates for 3.16. It merges cleanly with
arm-soc 'next/soc' head. As already discussed, the $subject pull request
has a depedency with DT dma-properties pull request [1] I sent last week
to be pulled into arm-soc.

The following changes since commit c9eaa447e77efe77b7fa4c953bd62de8297fd6c5:

  Linux 3.15-rc1 (2014-04-13 14:18:35 -0700)

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/ssantosh/linux-keystone.git tags/keystone-soc

for you to fetch changes up to 14f3791439b5a6cf12127fb80204265533d92664:

  ARM: keystone: Update the dma offset for non-dt platform devices (2014-05-08 15:43:33 -0400)

----------------------------------------------------------------
Keystone SOC updates for 3.16

- Drop unused COMMON_CLK_DEBUG option
- Enable MTD_SPI_NOR config needed for M25P80
- Enable coherent higher address memory space

----------------------------------------------------------------
Brian Norris (1):
      ARM: configs: keystone: add MTD_SPI_NOR (new dependency for M25P80)

Lad Prabhakar (1):
      ARM: configs: keystone: drop CONFIG_COMMON_CLK_DEBUG

Santosh Shilimkar (2):
      ARM: keystone: Switch over to coherent memory address space
      ARM: keystone: Update the dma offset for non-dt platform devices

 arch/arm/configs/integrator_defconfig   |    1 -
 arch/arm/configs/keystone_defconfig     |    2 +-
 arch/arm/configs/sunxi_defconfig        |    1 -
 arch/arm/configs/vt8500_v6_v7_defconfig |    1 -
 arch/arm/mach-keystone/keystone.c       |   74 +++++++++++++++++++++++++++++++
 arch/arm/mach-keystone/memory.h         |   24 ++++++++++
 arch/arm/mach-keystone/platsmp.c        |   18 +++++++-
 7 files changed, 116 insertions(+), 5 deletions(-)
 create mode 100644 arch/arm/mach-keystone/memory.h

Regards,
Santosh

[1] https://lkml.org/lkml/2014/5/7/368
