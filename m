From: net147@gmail.com (Jonathan Liu)
Date: Tue,  9 Jan 2018 13:03:20 +1100
Subject: [PATCH v3 0/3] drm/sun4i: hdmi: Fix sun4i_tmds_determine_rate
Message-ID: <20180109020323.11852-1-net147@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This patchset fixes several issues in sun4i_tmds_determine_rate that I
discovered while trying to get a projector connected to an Olimex
A20-OLinuXino-LIME using HDMI with a native resolution of 1280x800 and
pixel clock of 83.5 MHz to display at its native resolution.

Changes for v3:
- Improve commit message for unset best_parent

Changes for v2:
- Split into separate patches for each issue
- Add details to commit message for reproducing issue

Jonathan Liu (3):
  drm/sun4i: hdmi: Check for unset best_parent in
    sun4i_tmds_determine_rate
  drm/sun4i: hdmi: Fix incorrect assignment in sun4i_tmds_determine_rate
  drm/sun4i: hdmi: Add missing rate halving check in
    sun4i_tmds_determine_rate

 drivers/gpu/drm/sun4i/sun4i_hdmi_tmds_clk.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

-- 
2.15.1
