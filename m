From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 26 Jan 2011 16:20:51 -0800
Subject: [PATCHv2 0/5] MSM: clock debugfs and cleanups
Message-ID: <1296087656-3693-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches were previously posted as part of a larger series.
I've refreshed these against the latest msm for-next branch.
They cleanup debugfs and the clock code and add support for
some proc_comm clocks.

Changes since v2:
 * Fix build breakage on 7x00
 * Split patch 1 in half

Matt Wagantall (1):
  msm: clock: Move debugfs code from clock.c to clock-debug.c

Stephen Boyd (4):
  msm: clock: Remove unused code and definitions
  msm: clock: Remove 7x30 and pcom includes from clock.h
  msm: clock: Invert debugfs directory layout
  msm: clock: Add support for more proc_comm clocks

 arch/arm/mach-msm/Makefile          |    3 +
 arch/arm/mach-msm/board-msm8x60.c   |    4 -
 arch/arm/mach-msm/clock-debug.c     |  131 +++++++++++++++++++++++++++++++
 arch/arm/mach-msm/clock-pcom.c      |    1 +
 arch/arm/mach-msm/clock-pcom.h      |    4 +-
 arch/arm/mach-msm/clock.c           |  148 ++---------------------------------
 arch/arm/mach-msm/clock.h           |   52 ++----------
 arch/arm/mach-msm/devices-msm7x00.c |    1 +
 arch/arm/mach-msm/devices-msm7x30.c |    3 +
 arch/arm/mach-msm/devices-qsd8x50.c |    7 ++
 10 files changed, 165 insertions(+), 189 deletions(-)
 create mode 100644 arch/arm/mach-msm/clock-debug.c

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
