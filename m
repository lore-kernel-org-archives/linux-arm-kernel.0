From: leonard.crestez@nxp.com (Leonard Crestez)
Date: Mon, 27 Aug 2018 14:10:36 +0300
Subject: [RESEND 0/5] drm/mxsfb: Fix runtime PM for unpowering lcdif block
Message-ID: <cover.1535367027.git.leonard.crestez@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Adding lcdif nodes to a power domain currently doesn't work, it results
in black/corrupted screens or hangs. While the driver does enable
runtime pm it does not deal correctly with the block being unpowered.

All patches in this series have review tags from a few weeks ago. I'm
resending this today because 4.19 rc1 was released. I'm not sure if this
matters for DRM but in some areas unrelated series get lost during the
merge window.

Marek/Phillip: Is one of you going to pick up these patches?

Link to v4: https://lkml.org/lkml/2018/8/8/573

Leonard Crestez (5):
  drm/mxsfb: Move axi clk enable/disable to crtc enable/disable
  drm/mxsfb: Fix initial corrupt frame when activating display
  drm/mxsfb: Add pm_runtime calls to pipe_enable/disable
  drm/mxsfb: Add PM_SLEEP support
  drm/mxsfb: Switch to drm_atomic_helper_commit_tail_rpm

 drivers/gpu/drm/mxsfb/mxsfb_crtc.c | 53 +++++++++++++++++++-----------
 drivers/gpu/drm/mxsfb/mxsfb_drv.c  | 40 ++++++++++++++++++++++
 2 files changed, 74 insertions(+), 19 deletions(-)

-- 
2.17.1
