From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 10 Feb 2015 22:16:31 +0800
Subject: [RFC PATCH 0/3] 
Message-ID: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

RK3288 hdmi eye-diagram test would fail when pixel clock is 148.5MHz,
and single-ended test would failed when display mode is 74.25MHz.
- Fix some code style, leave space for next patches.
- For hdmi eye-diagram test, we turn on the Transmitter Trailer-B and
  improve slopeboost to 25%-30% decrease.
- For hdmi single-ended test, we set CKLVL & TXLVL to 17 when pixel
  clock is 74.25MHz, keep CKLVL & TXLVL to 13 when pixel clock is 148.5MHz.


Yakir Yang (3):
  drm: bridge/dw_hdmi: fixed codec style
  drm: bridge/dw_hdmi_rockchip: improve hdmi eye-diagram test
  drm: bridge/dw_hdmi: improve hdmi single-end test

 drivers/gpu/drm/bridge/dw_hdmi.c            |   20 ++++++++++----------
 drivers/gpu/drm/imx/dw_hdmi-imx.c           |   12 ++++++------
 drivers/gpu/drm/rockchip/dw_hdmi-rockchip.c |   14 +++++++-------
 include/drm/bridge/dw_hdmi.h                |    5 +++--
 4 files changed, 26 insertions(+), 25 deletions(-)

-- 
1.7.9.5
