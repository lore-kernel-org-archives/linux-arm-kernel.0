From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  8 Nov 2011 10:33:02 -0800
Subject: [PATCHv3 0/2] MSM8660/8960 DEBUG_LL support and cleanups
Message-ID: <1320777184-22446-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These changes are based on 3.2-rc1.

Changes since v2:
 * Don't use readl/writel directly in uncompress.h as that's
   kernel functionality and not decompress functionality

Stephen Boyd (2):
  ARM: msm: Consolidate and move DEBUG_LL to DEBUG_LL choice
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
 arch/arm/mach-msm/include/mach/uncompress.h     |   39 ++++++++++++++----
 arch/arm/mach-msm/io.c                          |   15 +++++-
 11 files changed, 137 insertions(+), 98 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
