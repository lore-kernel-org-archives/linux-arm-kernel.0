From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 19 Sep 2012 00:00:39 -0700
Subject: [PATCH 0/5] Trim down mach includes in MSM drivers
Message-ID: <1348038044-1790-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series trims the usage of mach includes in MSM 
drivers. In particular it targets the msm_iomap.h header
file and completely removes the cpu.h header file. After
this series we only have one driver using the iomap.h file
outside of mach-msm. Once that driver is moved to be
a platform device we can make msm_iomap.h private to mach-msm.

This series is based on linux-next-20120917, which has the msm
DT timer patches (the other user of cpu.h in MSM).

Patches 2 and 3 can probably be routed the appropriate subsystem
trees if desired. It would be good if patch 1, 4, and 5 go
through the MSM tree, so it may be easier to just put all these
patches through the MSM tree.

Stephen Boyd (5):
  ARM: msm: Move dma.h #defines that are private to dma.c
  mmc: msm_sdcc: Remove unnecessary include
  video: msm: Remove useless mach/* includes
  gpio: Make gpio-msm-v1 into a platform driver
  ARM: msm: Remove unused cpu.h header file

 arch/arm/mach-msm/board-halibut.c    |   1 +
 arch/arm/mach-msm/board-msm7x30.c    |   1 +
 arch/arm/mach-msm/board-qsd8x50.c    |   1 +
 arch/arm/mach-msm/board-trout.c      |   1 +
 arch/arm/mach-msm/devices-msm7x00.c  |  31 +++++
 arch/arm/mach-msm/devices-msm7x30.c  |  31 +++++
 arch/arm/mach-msm/devices-qsd8x50.c  |  31 +++++
 arch/arm/mach-msm/devices.h          |   4 +
 arch/arm/mach-msm/dma.c              |  26 +++++
 arch/arm/mach-msm/include/mach/cpu.h |  54 ---------
 arch/arm/mach-msm/include/mach/dma.h |  26 -----
 drivers/gpio/gpio-msm-v1.c           | 220 ++++++++++++++++++++++++-----------
 drivers/mmc/host/msm_sdcc.c          |   1 -
 drivers/video/msm/mddi.c             |   3 -
 drivers/video/msm/mdp.c              |   1 -
 drivers/video/msm/mdp_hw.h           |   1 -
 16 files changed, 276 insertions(+), 157 deletions(-)
 delete mode 100644 arch/arm/mach-msm/include/mach/cpu.h

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
