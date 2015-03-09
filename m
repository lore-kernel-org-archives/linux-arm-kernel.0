From: ykk@rock-chips.com (Yakir Yang)
Date: Mon,  9 Mar 2015 12:36:12 +0800
Subject: [PATCH v2 0/3] Improve eye-diagram & single-ended test for rk3288 hdmi
Message-ID: <1425875772-21252-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


RK3288 hdmi eye-diagram test would fail when pixel clock is 148.5MHz,
and single-ended test would failed when display mode is 74.25MHz.

To fix such problems, we make those patch set:
- Fix some code style, leave space for next patches.
- For hdmi eye-diagram test, we turn on the Transmitter Trailer-B and
  improve slopeboost to 10%-20% decrease.
- For hdmi single-ended test, we set CKLVL to 18 and & TXLVL to 19 when
  pixel clock is 74.25MHz, keep CKLVL & TXLVL to 13 when pixel clock is
  148.5MHz.

Changes in v2:
- set slopeboost back to 10%-20%, then rasing/falling time would pass.
- For pixel clock less than 74.25MHz, set txlvl to 19 and set cklvl to 18.

Yakir Yang (3):
  drm: bridge/dw_hdmi: fixed codec style
  drm: bridge/dw_hdmi_rockchip: improve hdmi eye-diagram test
  drm: bridge/dw_hdmi: improve hdmi single-end test

 drivers/gpu/drm/bridge/dw_hdmi.c            | 20 ++++++++++----------
 drivers/gpu/drm/imx/dw_hdmi-imx.c           | 12 ++++++------
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c | 14 +++++++-------
 include/drm/bridge/dw_hdmi.h                |  5 +++--
 4 files changed, 26 insertions(+), 25 deletions(-)

-- 
2.1.2
