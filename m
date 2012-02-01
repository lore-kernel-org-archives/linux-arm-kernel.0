From: will.deacon@arm.com (Will Deacon)
Date: Wed,  1 Feb 2012 14:03:10 +0000
Subject: [PATCH v3 0/2] Remaining VFP fixes
Message-ID: <1328104992-8016-1-git-send-email-will.deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This is v3 of the patches originally posted here:

v1: http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082168.html
v2: http://lists.infradead.org/pipermail/linux-arm-kernel/2012-January/082383.html

Patches 1-3 from v2 of the series are now in the patch system, so this
posting is a rework of what was previously patch 4/4.

The main change is that the VFP save/restore code is now moved out of
signal.c and into vfpmodule.c, since that is where the low-level
knowledge belongs.

I tested the changes with the `risu' tool for 24 hours on my (A9)
vexpress without any issues.

Cheers,

Will


Will Deacon (2):
  ARM: vfp: move user vfp state save/restore code out of signal.c
  ARM: vfp: clear fpscr length and stride bits on entry to sig handler

 arch/arm/include/asm/thread_info.h |    7 +++
 arch/arm/kernel/signal.c           |   57 ++-------------------
 arch/arm/vfp/vfpmodule.c           |   99 ++++++++++++++++++++++++++++++++++++
 3 files changed, 111 insertions(+), 52 deletions(-)

-- 
1.7.4.1
