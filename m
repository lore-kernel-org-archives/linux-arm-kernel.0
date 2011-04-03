From: john.linn@xilinx.com (John Linn)
Date: Sun, 3 Apr 2011 15:00:15 -0600
Subject: [PATCH 0/3] ARM: Xilinx: Adding SMP Support
Message-ID: <2bd38752-765c-4d7c-9ba6-0e62fbfb45ec@VA3EHSMHS006.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch series adds SMP to the Xilinx ARM platform.
The entire patch set must be used. I only broke it up into logical 
pieces to make the review easier (I hope).

This code has been tested against 2.6.39-rc1. The only checkpatch 
warnings are about usage of NR_CPUS which seems to how the other
platforms do it also.

I appreciate anyone's time who can review the patch set.

Thanks,
John

 arch/arm/Kconfig                               |    2 
 arch/arm/mach-xilinx/Makefile                  |    3 
 arch/arm/mach-xilinx/common.c                  |   16 ++
 arch/arm/mach-xilinx/common.h                  |    2 
 arch/arm/mach-xilinx/headsmp.S                 |   59 +++++++++
 arch/arm/mach-xilinx/include/mach/irqs.h       |    1 
 arch/arm/mach-xilinx/include/mach/smp.h        |   30 ++++
 arch/arm/mach-xilinx/include/mach/xilinx_soc.h |   20 +++
 arch/arm/mach-xilinx/localtimer.c              |   36 +++++
 arch/arm/mach-xilinx/platsmp.c                 |  160 ++++++++++++++++++++++++-
 arch/arm/mach-xilinx/timer.c                   |    5 
 11 files changed, 327 insertions(+), 7 deletions(-)


This email and any attachments are intended for the sole use of the named recipient(s) and contain(s) confidential information that may be proprietary, privileged or copyrighted under applicable law. If you are not the intended recipient, do not read, copy, or forward this email message or any attachments. Delete this email message and any attachments immediately.
