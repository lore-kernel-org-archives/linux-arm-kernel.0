From: jtzhou@marvell.com (Jett.Zhou)
Date: Thu, 27 Jun 2013 19:27:53 +0800
Subject: [V3 0/7] Enhance mmp display driver
Message-ID: <1372332473-6584-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changelog:
1 Add more comments for the mmp_display rbswap usage 
according to Daniel's comments;
2 Add fix patch for ttc_dkb on rbswap;
3 Add more comments on the pitch usage and definition;
4 Combine the modification on pitch of graphic and video layer
in one patch.

Guoqing Li (2):
  video: mmp: rb swap setting update for mmp display
  video: mmp: optimize some register setting code

Jett.Zhou (1):
  ARM: mmp: remove the legacy rbswap setting for ttc_dkb platform

Jing Xiang (4):
  video: mmp: fix graphics/video layer enable/mask issue
  video: mmp: fix memcpy wrong size for mmp_addr issue
  video: mmp: calculate pitch value when fb set win
  video: mmp: add pitch info in mmp_win structure

 arch/arm/mach-mmp/ttc_dkb.c     |    4 +-
 drivers/video/mmp/fb/mmpfb.c    |   34 +++++++++++------
 drivers/video/mmp/hw/mmp_ctrl.c |   79 ++++++++++++++++++++++-----------------
 drivers/video/mmp/hw/mmp_ctrl.h |    5 ++
 include/video/mmp_disp.h        |    6 +++
 5 files changed, 79 insertions(+), 49 deletions(-)
