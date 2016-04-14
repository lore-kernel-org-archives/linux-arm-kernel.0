From: david@lechnology.com (David Lechner)
Date: Thu, 14 Apr 2016 14:13:34 -0500
Subject: [PATCH 0/2] da8xx clocks (was part of "da8xx USB clocks")
Message-ID: <1460661217-7389-1-git-send-email-david@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I have separated these patches from the "da8xx USB clocks" series since that
series no longer depends on the clock init being moved.

Tested working on the linux-davinci/master branch with LEGO MINDSTORMS EV3.

David Lechner (2):
  ARM: davinci: Move clock init after ioremap.
  ARM: davinci: da850: use clk->set_parent for async3

 arch/arm/mach-davinci/clock.c  |  2 +-
 arch/arm/mach-davinci/common.c |  6 ---
 arch/arm/mach-davinci/da830.c  |  2 +
 arch/arm/mach-davinci/da850.c  | 90 ++++++++++++++++++++----------------------
 arch/arm/mach-davinci/dm355.c  |  1 +
 arch/arm/mach-davinci/dm365.c  |  1 +
 arch/arm/mach-davinci/dm644x.c |  1 +
 arch/arm/mach-davinci/dm646x.c |  1 +
 8 files changed, 49 insertions(+), 55 deletions(-)

-- 
1.9.1
