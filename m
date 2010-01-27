From: adharmap@codeaurora.org (adharmap at codeaurora.org)
Date: Wed, 27 Jan 2010 11:32:24 -0800
Subject: [PATCH 0/5] Arm Gic Changes
Message-ID: <1264620749-24527-1-git-send-email-adharmap@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Abhijeet Dharmapurikar <adharmap@quicinc.com>

Few fixes and improvements to arch/arm/common/gic.c file.

Abhijeet Dharmapurikar (5):
  gic: prevent gic from crossing NR_IRQ
  gic: add callback for mask_ack
  gic: Add set_type callback
  gic: dont disable INT in ack callback
  gic: initialize interrupts as per argument

 arch/arm/common/gic.c                    |  114 ++++++++++++++++++++++++-----
 arch/arm/include/asm/hardware/gic.h      |    3 +-
 arch/arm/mach-omap2/board-4430sdp.c      |    3 +-
 arch/arm/mach-realview/realview_eb.c     |   10 ++-
 arch/arm/mach-realview/realview_pb1176.c |    7 ++-
 arch/arm/mach-realview/realview_pb11mp.c |    7 ++-
 arch/arm/mach-realview/realview_pba8.c   |    4 +-
 arch/arm/mach-realview/realview_pbx.c    |    5 +-
 arch/arm/mach-ux500/cpu-u8500.c          |    2 +-
 9 files changed, 122 insertions(+), 33 deletions(-)
