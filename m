From: sboyd@codeaurora.org (Stephen Boyd)
Date: Mon,  4 Aug 2014 18:31:42 -0700
Subject: [PATCH 0/8] qcom SCM updates
Message-ID: <1407202310-3359-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The SCM code in the mainline kernel is woefully out of data from what
is in the downstream msm kernels. Update the code to be at least 
functionally correct and useful for features like cpuidle and
suspend.

Olav Haugan (1):
  msm: scm: Add logging of actual return code from scm call

Saravana Kannan (1):
  msm: scm: Add API to query for service/command availability.

Stephen Boyd (5):
  msm: scm: Fix incorrect cache invalidation
  msm: scm: Get cacheline size from CTR
  msm: scm: Add atomic SCM APIs
  msm: scm: Add a feat version query API
  msm: scm: Move the scm driver to drivers/soc/qcom

Vikram Mulukutla (1):
  msm: scm: Flush the command buffer only instead of the entire cache

 arch/arm/mach-qcom/Kconfig                     |   3 -
 arch/arm/mach-qcom/Makefile                    |   4 +-
 arch/arm/mach-qcom/scm-boot.c                  |   2 +-
 drivers/soc/qcom/Kconfig                       |   2 +
 drivers/soc/qcom/Makefile                      |   2 +
 {arch/arm/mach-qcom => drivers/soc/qcom}/scm.c | 162 ++++++++++++++++++++++---
 {arch/arm/mach-qcom => include/soc/qcom}/scm.h |   8 +-
 7 files changed, 158 insertions(+), 25 deletions(-)
 rename {arch/arm/mach-qcom => drivers/soc/qcom}/scm.c (62%)
 rename {arch/arm/mach-qcom => include/soc/qcom}/scm.h (69%)

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
hosted by The Linux Foundation
