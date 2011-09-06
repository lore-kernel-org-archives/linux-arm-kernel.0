From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue,  6 Sep 2011 13:48:25 +0800
Subject: [PATCH v2 0/2] make reinitialization of ARM core components possible
Message-ID: <1315288107-14689-1-git-send-email-shawn.guo@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When ARM core resumes from low-power mode where losing power, for my
example: CA-9 MPCore resumes from Dormant/Shutdown, we have to
reinitialize components like L2 Cache, GIC and SCU to bring system
back to work.

The patch set basically removes __init annotation from a bunch of
initialization functions, so that platform resume procedure can call
into them again to set those components up.

Changes since v1:
 * Drop the GIC patch, as it's been handled by [1] nicely.
 * Drop the change of adding empty l2x0_of_init(), as it's been
   handled by [2].

Shawn Guo (2):
      ARM: cache-l2x0: remove __init annotation from initialization functions
      ARM: smp_scu: remove __init annotation from scu_enable()

 arch/arm/include/asm/hardware/cache-l2x0.h |    2 +-
 arch/arm/kernel/smp_scu.c                  |    2 +-
 arch/arm/mm/cache-l2x0.c                   |   10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

[1] [PATCH v2 0/5] CPU PM notifiers
http://thread.gmane.org/gmane.linux.ports.arm.kernel/131212/focus=131353

[2] [PATCH 1/7] ARM: l2x0: add empty l2x0_of_init
http://article.gmane.org/gmane.linux.ports.arm.kernel/130878
