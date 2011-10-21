From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 20 Oct 2011 21:28:30 -0700
Subject: [PATCHv2 0/2] Update MSM DEBUG_LL support
Message-ID: <1319171312-21113-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This is a reroll of the MSM DEBUG_LL patches. They incorporate
feedback from Nico and are rebased on top of rmk's debug branch.
My understanding is the debug branch is a stable branch to build
up low-level debug on.

Stephen Boyd (2):
  msm: Consolidate and move DEBUG_LL to generic ARM Kconfig
  msm: Support DEBUG_LL on MSM8660 and MSM8960

 arch/arm/Kconfig.debug                          |   37 ++++++++++++++++
 arch/arm/mach-msm/Kconfig                       |   35 +--------------
 arch/arm/mach-msm/include/mach/debug-macro.S    |   51 ++++++++++++++--------
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |   12 -----
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h |   12 -----
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h |    5 ++
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |   12 -----
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h |    5 ++
 arch/arm/mach-msm/include/mach/msm_iomap.h      |   12 +++++
 arch/arm/mach-msm/include/mach/uncompress.h     |   31 ++++++++++----
 arch/arm/mach-msm/io.c                          |   15 +++++-
 11 files changed, 129 insertions(+), 98 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
