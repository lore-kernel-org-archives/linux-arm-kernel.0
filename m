From: dianders@chromium.org (Douglas Anderson)
Date: Wed,  6 Sep 2017 13:51:58 -0700
Subject: [PATCH 0/3] phy: rockchip-typec: Set "flip" at the right time;
 some cleanups
Message-ID: <20170906205201.16207-1-dianders@chromium.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

When connecting to certain DP monitors it was observed that only one
of the two orientations of the type C to DP cable would work.
Debugging showed that the problem was that we needed to set the type C
"flip" state earlier.  Once we did this, problems went away.

While trying to dig into this problem and some others, I found that
the proper documentation for the Type C PHY was available to me.  This
allowed me to cleanup the magic numbers in the funtion that I was
touching and also fix a few minor issues that (luckily) haven't caused
any problems yet.

For this series I've added Chris Zhong's Reviewed-by tags since he
gave a +1 to nearly identical patches on the Chrome OS gerrit and I
didn't think he'd mind me carrying his tag.  If folks would rather I
didn't do that, please yell.


Douglas Anderson (3):
  phy: rockchip-typec: Set the AUX channel flip state earlier
  phy: rockchip-typec: Avoid magic numbers + add delays in aux calib
  phy: rockchip-typec: Do the calibration more correctly

 drivers/phy/rockchip/phy-rockchip-typec.c | 247 ++++++++++++++++++++++++------
 1 file changed, 202 insertions(+), 45 deletions(-)

-- 
2.14.1.581.gf28d330327-goog
