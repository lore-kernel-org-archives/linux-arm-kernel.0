From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Jun 2013 17:43:30 +0100
Subject: [PATCH v2 0/2] ARM: Remove any correlation between IPC and BogoMips
 value
Message-ID: <1371746612-23950-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

This is version two of the patches I originally posted here:

  http://lists.infradead.org/pipermail/linux-arm-kernel/2013-May/166728.html

Comments received there largely confirmed that it's not possible to choose
an `obviously bogus' value for BogoMIPs, so instead I've bitten the bullet
and removed the line altogether.

In the meantime, I've only had one complaint this month about BogoMIPs
being wrong, so perhaps the initial posting served some purpose without
even being merged!

Comments welcome,

Will


Will Deacon (2):
  ARM: delay: don't bother reporting bogomips in /proc/cpuinfo
  init: calibrate: don't print out bogomips value on boot

 arch/arm/kernel/setup.c |  9 ---------
 arch/arm/kernel/smp.c   | 13 ++-----------
 init/calibrate.c        |  8 +++-----
 3 files changed, 5 insertions(+), 25 deletions(-)

-- 
1.8.2.2
