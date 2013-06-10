From: jtzhou@marvell.com (Jett.Zhou)
Date: Mon, 10 Jun 2013 23:52:01 +0800
Subject: [V2 0/7] Enhanced mmp fb driver and bugfix 
Message-ID: <1370879521-10962-1-git-send-email-jtzhou@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

1 Enhanced some api/register operation routine
2 Fix some bugs like memcpy and graphics/video layer enable/mask swap;
3 Add pitch info and video layer set win/addr operations support

Guoqing Li (2):
  video: mmp: rb swap setting update for new LCD driver
  video: mmp: optimize some register setting code

Jing Xiang (5):
  video: mmp: fix graphics/video layer enable/mask swap issue
  video: mmp: fix memcpy wrong size for mmp_addr issue
  video: mmp: add pitch info in mmp_win structure
  video: mmp: calculate pitch value when fb set win
  video: mmp: add video layer set win/addr operations support

 drivers/video/mmp/fb/mmpfb.c    |   34 +++++++++++------
 drivers/video/mmp/hw/mmp_ctrl.c |   75 ++++++++++++++++++++++-----------------
 drivers/video/mmp/hw/mmp_ctrl.h |    4 ++
 include/video/mmp_disp.h        |    3 ++
 4 files changed, 71 insertions(+), 45 deletions(-)
