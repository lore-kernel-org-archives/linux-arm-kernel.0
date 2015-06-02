From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue,  2 Jun 2015 12:12:56 -0700
Subject: [PATCH v2 0/2] Fix cpuidle on qcom's THUMB2 kernels
Message-ID: <1433272378-8470-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I split this patch into two now that we have the cpu_resume_arm()
wrapper. The first patch could go through rmk's tree and then be
provided at some stable branch so that the second patch could go
through arm-soc. Or the two patches could go through arm-soc and
be squashed into one patch or stay split out. Either way, we have a
cross maintainer dependency here that needs to be resolved.

Changes from v1:
 * Add cpu_resume_arm() wrapper
 * New patch to fix up spm code to use new wrapper

Stephen Boyd (2):
  ARM: Add cpu_resume_arm() for firmwares that resume in ARM state
  soc: qcom: spm: Fix idle on THUMB2 kernels

 arch/arm/include/asm/suspend.h | 1 +
 arch/arm/kernel/sleep.S        | 7 +++++++
 drivers/soc/qcom/spm.c         | 2 +-
 3 files changed, 9 insertions(+), 1 deletion(-)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
