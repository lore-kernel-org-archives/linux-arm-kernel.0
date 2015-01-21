From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 21 Jan 2015 11:48:16 -0800
Subject: [PATCH 0/2] Fix secondary CPU boot for thumb2 kernels
Message-ID: <1421869698-27341-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Currently I can't boot up secondary CPUs on qcom platforms when I
compile the kernel for THUMB2 mode. This is because we always enter
the kernel in ARM mode regardless of what mode the kernel is compiled
for. This patchset adds a small wrapper to secondary_startup() called
secondary_startup_arm() that allows us to switch into THUMB2 mode if
we need to. If the kernel is compiled for ARM mode it shouldn't have
any effect.

Stephen Boyd (2):
  ARM: Add a secondary_startup that assumes ARM mode
  ARM: qcom: Use secondary_startup_arm()

 arch/arm/kernel/head.S       | 7 +++++++
 arch/arm/mach-qcom/platsmp.c | 4 ++--
 2 files changed, 9 insertions(+), 2 deletions(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
