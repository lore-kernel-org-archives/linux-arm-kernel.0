From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Thu,  1 Dec 2016 22:00:18 +0100
Subject: [PATCH 0/2] clk: bcm2835: Propage rate change to PLLH
Message-ID: <1480626020-20031-1-git-send-email-boris.brezillon@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

The VEC (Video EnCoder) clock needs to be running at precisely 108Mhz
for the VEC IP to work properly.
Unfortunately, the current implementation does not propate peripheral
clock rate change to their parents, which prevents us from getting
the 108Mhz rate unless the PLLH and PLLH_AUX clocks are already
configured (by the bootloader) to a multiple of 108Mhz.

This series adds support for optional per-periph-clk rate change
propagation and enables this feature on the VEC clock.

Regards,

Boris

Boris Brezillon (2):
  clk: bcm: Support rate change propagation on bcm2835 clocks
  clk: bcm: Allow rate change propagation to PLLH_AUX on VEC clock

 drivers/clk/bcm/clk-bcm2835.c | 74 ++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 69 insertions(+), 5 deletions(-)

-- 
2.7.4
