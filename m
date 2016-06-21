From: tony@atomide.com (Tony Lindgren)
Date: Tue, 21 Jun 2016 00:52:41 -0700
Subject: [PATCH 0/4] Get kexec working on SMP omap variants
Message-ID: <1466495565-17480-1-git-send-email-tony@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Here are some patches to make kexec work for SMP omaps. To test
these you need to use the latest kexec-tools.git kexec with
Russell's recent patches in "[PATCH 0/2] Simple fix to the ARM
kexec tools implementation" thread fixed for 6x. Or else you
need to use appended DTB.

I've tested these so far on 4430 duovero, omap5-uevm, and
beagle-x15.

Regards,

Tony


Tony Lindgren (4):
  ARM: OMAP4+: Initialize SAR RAM base early for proper CPU1 reset for
    kexec
  ARM: OMAP4+: Prevent CPU1 related hang with kexec
  ARM: OMAP4+: Reset CPU1 properly for kexec
  ARM: OMAP4+: Allow kexec on SMP variants

 arch/arm/mach-omap2/Makefile              |  4 +-
 arch/arm/mach-omap2/common.h              |  8 ++-
 arch/arm/mach-omap2/io.c                  |  3 +
 arch/arm/mach-omap2/omap-hotplug.c        |  6 ++
 arch/arm/mach-omap2/omap-mpuss-lowpower.c | 29 ++++++++--
 arch/arm/mach-omap2/omap-smp.c            | 96 ++++++++++++++++++++++---------
 arch/arm/mach-omap2/omap4-common.c        | 14 ++---
 7 files changed, 118 insertions(+), 42 deletions(-)

-- 
2.8.1
