From: johlstei@codeaurora.org (Jeff Ohlstein)
Date: Mon, 14 Mar 2011 22:01:03 -0700
Subject: [PATCH 00/11] Support for msm8660 and msm8960 dma
Message-ID: <1300165274-8544-1-git-send-email-johlstei@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series does cleanup on the msm dma driver, and adds support for two
new targets, msm8660 and msm8960.

Jeff Ohlstein (9):
  msm: dma: Add support for flushing dma channels
  msm: dma: support using dma from modules
  msm: dma: Toggle adm_pclk along with adm_clk
  msm: dma: Remove register macros from header file
  msm: dma: use a platform device for msm_dmov
  msm: dma: Support multiple adms
  msm: dma: Handle probe failure in dma function
  msm: dma: Support msm8x60 dma
  msm: dma: support msm8960 dma

Stepan Moskovchenko (1):
  msm: 8960: Split out common initialization code

Subhash Jadavani (1):
  msm: dma: Guard for multiple file inclusion

 arch/arm/mach-msm/Makefile                      |    5 +-
 arch/arm/mach-msm/board-halibut.c               |    1 +
 arch/arm/mach-msm/board-mahimahi.c              |    1 +
 arch/arm/mach-msm/board-msm7x30.c               |    1 +
 arch/arm/mach-msm/board-msm8960.c               |   14 +-
 arch/arm/mach-msm/board-msm8x60.c               |    9 +-
 arch/arm/mach-msm/board-qsd8x50.c               |    1 +
 arch/arm/mach-msm/board-trout.c                 |    1 +
 arch/arm/mach-msm/devices-msm7x00.c             |   21 ++-
 arch/arm/mach-msm/devices-msm7x30.c             |   21 ++-
 arch/arm/mach-msm/devices-msm8960.c             |   21 ++
 arch/arm/mach-msm/devices-msm8x60.c             |   56 ++++
 arch/arm/mach-msm/devices-qsd8x50.c             |   21 ++-
 arch/arm/mach-msm/devices.h                     |    5 +
 arch/arm/mach-msm/dma.c                         |  391 ++++++++++++++++++-----
 arch/arm/mach-msm/include/mach/dma.h            |   84 +++---
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |    5 +-
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h |    5 +-
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h |    3 +
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |    5 +-
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h |    6 +
 arch/arm/mach-msm/io.c                          |    3 -
 22 files changed, 545 insertions(+), 135 deletions(-)
 create mode 100644 arch/arm/mach-msm/devices-msm8x60.c

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
