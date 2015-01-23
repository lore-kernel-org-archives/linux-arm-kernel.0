From: wxt@rock-chips.com (Caesar Wang)
Date: Fri, 23 Jan 2015 23:49:13 +0800
Subject: [PATCH v5 0/1] thermal: rockchip: make temperature reporting much
 more accurate
Message-ID: <1422028154-2349-1-git-send-email-wxt@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


This patch is merged on chromiumos/third_party/kernel.
https://chromium-review.googlesource.com/#/c/239190/

Tested on veyron boards.


Changes in v5:
Fixed some style.

Changes in v4:
"return -EAGAIN" instead of "return rk_tsadcv2_code_to_temp(code)"

Changes in v3:
Suggested-by Daniel Kurtz,
the check doesn't reject "code == 0xfff"
Fixed in rk_tsadcv2_code_to_temp(u32 code)

Changes in v2:
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Caesar Wang (1):
  thermal: rockchip: make temperature reporting much more accurate

 drivers/thermal/rockchip_thermal.c | 38 +++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 13 deletions(-)

-- 
1.9.1
