From: koba@kmckk.co.jp (Tetsuyuki Kobayashi)
Date: Wed, 10 Jul 2013 10:56:34 +0900
Subject: [PATCH 0/3] ARM: shmobile: enable SMP Thumb2 kernel
Message-ID: <1373421397-1786-1-git-send-email-koba@kmckk.co.jp>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I try to build SMP kernel for KZM-A9-GT board in CONFIG_THUMB2_KERNEL=y.
After some modification it successully boots in Thumb2 kernel.
In my case, Thumb2 kernel is 23% smaller than usual ARM kernel.

   text	   data	    bss	    dec	    hex	filename
4763561	 251580	 196164	5211305	 4f84a9	out.kzm9g/vmlinux

   text	   data	    bss	    dec	    hex	filename
3595265	 251668	 196164	4043097	 3db159	out.kzm9g_thumb/vmlinux


Useful info for Thumb2 kernel
https://wiki.linaro.org/WorkingGroups/KernelArchived/Thumb2Guide

This patch set is based on arm-soc git repositry, 
remotes/origin/renesas/soc-cleanup branch
53332005bfde9d2e3c9a66030c0e8c2598eaa1d5 ARM: shmobile: Remove Bonito board support

Tetsuyuki Kobayashi (3):
  ARM: shmobile: fix compile error when CONFIG_THUMB2_KERNEL=y
  ARM: shmobile: Force ARM mode to compile reset vector for secondary
    CPUs
  ARM: shmobile: Insert align directives before 4 bytes data

 arch/arm/mach-shmobile/headsmp-scu.S  |    4 +++-
 arch/arm/mach-shmobile/headsmp.S      |    6 +++++-
 arch/arm/mach-shmobile/sleep-sh7372.S |    2 ++
 3 files changed, 10 insertions(+), 2 deletions(-)

-- 
1.7.9.5
