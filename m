From: computersforpeace@gmail.com (Brian Norris)
Date: Mon, 29 Sep 2014 18:35:25 -0700
Subject: [PATCH 0/5] ARM: move #include <asm/cp15.h> into cacheflush.h
Message-ID: <1412040930-16864-1-git-send-email-computersforpeace@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There are several places where an explicit include of <asm/cp15.h> is needed
just because cacheflush.h uses one of its macros in v7_exit_coherency_flush().
Let's put the include in the proper header.

These obviously have some dependencies, so I'd focus on:
  (1) Is patch 1 acceptable? If so, then:
  (2) Make sure patch 1 is serialized before the rest

I did a cursory scan of every file that includes cp15.h, and these are the only
ones I found that only needed it for the sake of v7_exit_coherency_flush().

These are barely compile tested.

Thanks,
Brian

Brian Norris (5):
  ARM: include missing cp15.h header
  ARM: mvebu: drop unnecessary include
  ARM: rockchip: drop unnecessary include
  ARM: vexpress: drop unnecessary include
  ARM: brcmstb: drop unnecessary include

 arch/arm/include/asm/cacheflush.h   | 1 +
 arch/arm/mach-bcm/platsmp-brcmstb.c | 1 -
 arch/arm/mach-mvebu/pmsu.c          | 1 -
 arch/arm/mach-rockchip/platsmp.c    | 1 -
 arch/arm/mach-vexpress/dcscb.c      | 1 -
 arch/arm/mach-vexpress/tc2_pm.c     | 1 -
 6 files changed, 1 insertion(+), 5 deletions(-)

-- 
1.9.1
