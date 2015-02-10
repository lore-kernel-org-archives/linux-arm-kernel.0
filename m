From: ykk@rock-chips.com (Yakir Yang)
Date: Tue, 10 Feb 2015 22:20:51 +0800
Subject: [RFC PATCH 0/1] Improve eye-diagram & single-ended test for rk3288
 hdmi
In-Reply-To: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
References: <1423577791-19238-1-git-send-email-ykk@rock-chips.com>
Message-ID: <1423578051-19425-1-git-send-email-ykk@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


RK3288 hdmi eye-diagram test would fail when pixel clock is 148.5MHz,
and single-ended test would failed when display mode is 74.25MHz.
- Fix some code style, leave space for next patches.
- For hdmi eye-diagram test, we turn on the Transmitter Trailer-B and
  improve slopeboost to 25%-30% decrease.
- For hdmi single-ended test, we set CKLVL & TXLVL to 17 when pixel
  clock is 74.25MHz, keep CKLVL & TXLVL to 13 when pixel clock is 148.5MHz.


Yakir Yang (1):
  drm: bridge/dw_hdmi: fixed codec style

 drivers/gpu/drm/bridge/dw_hdmi.c |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

-- 
1.7.9.5
