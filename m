From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 28 Sep 2011 14:05:57 -0700
Subject: [PATCH 0/2] Update MSM DEBUG_LL support
Message-ID: <1317243959-26383-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches consolidate the current DEBUG_LL code in MSM; moving
the configs to the toplevel DEBUG_LL choice. They also add support
for 8660 and 8960 low level debug.

Patches are based on linux-next-20110927

Stephen Boyd (2):
  msm: Consolidate and move DEBUG_LL to generic ARM Kconfig
  msm: Support DEBUG_LL on MSM8660 and MSM8960

 arch/arm/Kconfig.debug                          |   37 +++++++++++++++++++
 arch/arm/mach-msm/Kconfig                       |   35 ++----------------
 arch/arm/mach-msm/include/mach/debug-macro.S    |   44 ++++++++++++++--------
 arch/arm/mach-msm/include/mach/msm_iomap-7x00.h |   12 ------
 arch/arm/mach-msm/include/mach/msm_iomap-7x30.h |   12 ------
 arch/arm/mach-msm/include/mach/msm_iomap-8960.h |    5 +++
 arch/arm/mach-msm/include/mach/msm_iomap-8x50.h |   12 ------
 arch/arm/mach-msm/include/mach/msm_iomap-8x60.h |    5 +++
 arch/arm/mach-msm/include/mach/msm_iomap.h      |   12 ++++++
 arch/arm/mach-msm/include/mach/uncompress.h     |   31 ++++++++++++----
 arch/arm/mach-msm/io.c                          |   15 ++++++--
 11 files changed, 125 insertions(+), 95 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
