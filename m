From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 22 Aug 2012 15:55:42 -0700
Subject: [PATCH 0/3] Miscellaneous MSM fixes
Message-ID: <1345676145-12321-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Here's a small collection of MSM patches I have lying around.
The first removes a useless file and hook that nobody is using.
The second marks some functions static in clock-pcom.c since
they aren't used outside the file and the last removes idle.c
because it's dead code.

Stephen Boyd (3):
  ARM: MSM: Remove msm_hw_reset_hook
  ARM: MSM: clock-pcom: Mark functions static
  ARM: MSM: Remove unused idle.c

 arch/arm/mach-msm/Makefile              |  2 +-
 arch/arm/mach-msm/board-mahimahi.c      |  1 -
 arch/arm/mach-msm/board-sapphire.c      |  1 -
 arch/arm/mach-msm/clock-pcom.c          | 18 ++++++------
 arch/arm/mach-msm/idle.c                | 49 ---------------------------------
 arch/arm/mach-msm/include/mach/system.h | 19 -------------
 arch/arm/mach-msm/proc_comm.c           |  1 -
 arch/arm/mach-msm/smd.c                 |  7 -----
 8 files changed, 10 insertions(+), 88 deletions(-)
 delete mode 100644 arch/arm/mach-msm/idle.c
 delete mode 100644 arch/arm/mach-msm/include/mach/system.h

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
