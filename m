From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 24 Feb 2011 10:44:41 -0800
Subject: [PATCH 0/4] SCM fixes and updates
Message-ID: <1298573085-23217-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These are a few updates to SCM. The first two patches fix some
bad code generation. The next patch saves a couple instructions
on the slow path and the final patch determines the cacheline
size dynamically instead of statically.

Stephen Boyd (4):
  msm: scm: Mark inline asm as volatile
  msm: scm: Fix improper register assignment
  msm: scm: Check for interruption immediately
  msm: scm: Get cacheline size from CTR

 arch/arm/mach-msm/scm.c |   75 +++++++++++++++++++++++++++-------------------
 1 files changed, 44 insertions(+), 31 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
