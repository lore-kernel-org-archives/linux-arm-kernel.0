From: m.krawczuk@partner.samsung.com (Mateusz Krawczuk)
Date: Fri, 30 Aug 2013 14:01:59 +0200
Subject: [PATCH v4 0/2] media: s5p-tv: clean-up and fixes
Message-ID: <1377864121-19587-1-git-send-email-m.krawczuk@partner.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patch series add restoring previous vpll rate after driver offs stream 
or recives error.
It also replace mxr_info, mxr_dbg, mxr_warn and mxr_err macro 
by generic solution.

Mateusz Krawczuk (2):
  media: s5p-tv: Replace mxr_ macro by default dev_
  media: s5p-tv: Restore vpll clock rate

 drivers/media/platform/s5p-tv/mixer.h           |  12 ---
 drivers/media/platform/s5p-tv/mixer_drv.c       |  47 ++++++-----
 drivers/media/platform/s5p-tv/mixer_grp_layer.c |   2 +-
 drivers/media/platform/s5p-tv/mixer_reg.c       |   6 +-
 drivers/media/platform/s5p-tv/mixer_video.c     | 100 ++++++++++++------------
 drivers/media/platform/s5p-tv/mixer_vp_layer.c  |   2 +-
 drivers/media/platform/s5p-tv/sdo_drv.c         |  25 +++++-
 7 files changed, 101 insertions(+), 93 deletions(-)

-- 
1.8.1.2
