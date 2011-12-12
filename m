From: linus.walleij@stericsson.com (Linus Walleij)
Date: Mon, 12 Dec 2011 10:56:22 +0100
Subject: [PATCH 0/4] SMP TWD localtimer patches, broken apart
Message-ID: <1323683782-23792-1-git-send-email-linus.walleij@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Linus Walleij <linus.walleij@linaro.org>

In order to avoid stalling all of the code in Colin Cross' classic
patch, I have taken the liberty to break it in four pieces, so we
can (hopefully) proceed with atleast some pieces of the patch.

I think patch 1 would be uncontroversial at least.

I think ST-Ericsson, TI and nVidia are all using this patch or some
variant of it in their recently shipped products, so if there is
something seriously wrong about it, we'd better find out.

Since the end result after all four patches are applied, is 100%
identical to the original patch, I have kept the Acked-by:s from
the big patch on each individual patch.

I will replace the single patch in the patch tracker with these four
patches soon-ish.

Linus Walleij (4):
  ARM: smp_twd: modernize clock event registration
  ARM: smp_twd: create a percpu reference to the clockevent
  ARM: smp_twd: get the rate from a clock
  ARM: smp_twd: reconfigure clockevents after cpufreq change

 arch/arm/kernel/smp_twd.c |   89 ++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 83 insertions(+), 6 deletions(-)

-- 
1.7.3.2
