From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 23 Feb 2011 09:37:40 -0800
Subject: [PATCH 0/2] Migrate MSM to clkdev
Message-ID: <1298482662-27298-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches migrate the current MSM clock code to clkdev. In
the process clock-dummy.c is removed since clk_get() implemented in
clkdev already returns -ENOENT for non-existent clocks.

Prepared against davidb/linx-msm.git for-next.

Stephen Boyd (2):
  msm: clock: Remove references to clk_ops_pcom
  msm: clock: Migrate to clkdev

 arch/arm/Kconfig                        |    1 +
 arch/arm/mach-msm/Makefile              |    6 +---
 arch/arm/mach-msm/board-msm7x30.c       |    1 +
 arch/arm/mach-msm/board-msm8960.c       |    1 +
 arch/arm/mach-msm/board-qsd8x50.c       |    1 +
 arch/arm/mach-msm/board-trout.c         |    1 +
 arch/arm/mach-msm/clock-7x30.h          |   30 ++++++++++-------
 arch/arm/mach-msm/clock-debug.c         |    3 +-
 arch/arm/mach-msm/clock-dummy.c         |   54 -------------------------------
 arch/arm/mach-msm/clock-pcom.c          |    6 +++
 arch/arm/mach-msm/clock-pcom.h          |   16 +++++----
 arch/arm/mach-msm/clock.c               |   50 ++++------------------------
 arch/arm/mach-msm/clock.h               |    3 +-
 arch/arm/mach-msm/devices-msm7x00.c     |   32 +++++++++---------
 arch/arm/mach-msm/devices-msm7x30.c     |    5 ++-
 arch/arm/mach-msm/devices-qsd8x50.c     |   23 +++++++------
 arch/arm/mach-msm/devices.h             |    8 +++--
 arch/arm/mach-msm/include/mach/board.h  |    4 +-
 arch/arm/mach-msm/include/mach/clkdev.h |   19 +++++++++++
 19 files changed, 105 insertions(+), 159 deletions(-)
 delete mode 100644 arch/arm/mach-msm/clock-dummy.c
 create mode 100644 arch/arm/mach-msm/include/mach/clkdev.h

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
