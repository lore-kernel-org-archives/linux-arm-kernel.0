From: will.deacon@arm.com (Will Deacon)
Date: Mon, 30 Jan 2012 11:24:51 +0000
Subject: [PATCH v2 0/4] Various VFP fixes
Message-ID: <1327922695-16121-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

This is version two of the patches I posted on Friday:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082168.html

The only changes are that patch 4 is no longer insane and the whole
series has had an extra weekend's worth of testing.

Feedback welcome.

Will

Cc: Dave Martin <dave.martin@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>

Dave Martin (1):
  ARM: vfp: fix ptrace regset modification race

Will Deacon (3):
  ARM: vfp: flush thread hwstate before restoring context from sigframe
  ARM: vfp: flush thread hwstate before copying ptrace registers
  ARM: vfp: clear fpscr length and stride bits on entry to sig handler

 arch/arm/kernel/ptrace.c |    8 +++++---
 arch/arm/kernel/signal.c |   20 +++++++++++++++++---
 2 files changed, 22 insertions(+), 6 deletions(-)

-- 
1.7.4.1
