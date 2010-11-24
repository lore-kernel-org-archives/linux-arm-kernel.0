From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 24 Nov 2010 15:56:58 -0800
Subject: [PATCH 0/2] Optimized inlining for ARM
Message-ID: <1290643020-24558-1-git-send-email-sboyd@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I know that Ingo deliberately introduced this option as x86
specific, but I'd like to introduce this for ARM as well. To
avoid useless copy paste, I've made the option generic so
any arch can support it.

In an effort to make a tiny crash kernel this option can shave a
few kb off the crash kernel size. It also helps a regular kernel
have a smaller icache footprint which should be benficial.
This option isn't on by default so there is no harm in adding it
besides giving the user a potentially dangerous option to enable.
If it's really experimental we can add an "if EXPERIMENTAL" in the
second patch. In the end, I'd like to get a wider range of testing with
this feature enabled on ARM so I'm posting it here in hopes that
people can respond back with Tested-by tags (or Naks if it crashes their
system).

Stephen Boyd (2):
  Make OPTIMIZE_INLINING a generic option
  arm: add optimized inlining

 arch/arm/Kconfig       |    1 +
 arch/x86/Kconfig       |    4 +---
 arch/x86/Kconfig.debug |   14 --------------
 init/Kconfig           |   18 ++++++++++++++++++
 4 files changed, 20 insertions(+), 17 deletions(-)

-- 
Sent by an employee of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
