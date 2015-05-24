From: hramrach@gmail.com (Michal Suchanek)
Date: Sun, 24 May 2015 20:25:58 +0200
Subject: [PATCH 0/2] sunxi a20 mmc timeout fix
Message-ID: <cover.1432491958.git.hramrach@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I had serious problems with root filesustem on SD card on Cubieboard2 when
clock gating was on.

It turns out that sunxi_mmc_oclk_onoff has way too short timeout ofr setting
the clock.

So here are some patches for

 - bumping the timout
 - spamming dmesg when the time to set the clock seems too long
 - setting SDXC_LOW_POWER_ON which is unset but never set

Also feel free to just bump the timeout to reasonably high value so the board
can boot reliably with mmc clock gating enabled.

Thanks

Michal

Michal Suchanek (2):
  mmc: sunxi: fix timeout in sunxi_mmc_oclk_onoff
  mmc: sunxi: Also set SDXC_LOW_POWER_ON

 drivers/mmc/host/sunxi-mmc.c | 24 +++++++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

-- 
2.1.4
