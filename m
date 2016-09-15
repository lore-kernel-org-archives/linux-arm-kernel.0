From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 15 Sep 2016 23:13:58 +0800
Subject: [PATCH 0/4] drm/sun4i: rgb and dotclock misc fixes and improvements
Message-ID: <20160915151402.15992-1-wens@csie.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

Here are a few small fixes and improvements to the sun4i drm driver.

Patch 1 declares the LCD panel RGB interface encoder and connector types
as MIPI DPI. AFAIK DPI is the parallel RGB variant.

Patch 2 fixes the weird clock rates I was getting on the dot clock when
testing the RGB-to-VGA bridge patches. You may want to queue this as a
fix for 4.8.

Patch 3 increases the dot clock divider upper bound by 1 to 127. AFAIK
127 is a valid divider. I doubt we will ever use it, since the parents
will go way higher than they are supposed to, but getting it right is
nicer.

Patch 4 changes the dot clock's behavior to make it round to the closest
clock rate. I think this would make it easier to match the LCD panel's
timings. More on the LCD timings in a later patch set.


Regards
ChenYu

Chen-Yu Tsai (4):
  drm/sun4i: rgb: Declare RGB encoder and connector as MIPI DPI
  drm/sun4i: dotclock: Fix clock rate read back calcation
  drm/sun4i: dotclock: Allow divider = 127
  drm/sun4i: dotclock: Round to closest clock rate

 drivers/gpu/drm/sun4i/sun4i_dotclock.c | 7 ++++---
 drivers/gpu/drm/sun4i/sun4i_rgb.c      | 4 ++--
 2 files changed, 6 insertions(+), 5 deletions(-)

-- 
2.9.3
