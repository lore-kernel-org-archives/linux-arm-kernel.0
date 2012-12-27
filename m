From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 27 Dec 2012 13:14:28 +1300
Subject: [PATCH 0/3] clk fixes for 3.8
Message-ID: <1356567272-3420-1-git-send-email-linux@prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike,

Three bugfixes for 3.8.

#1 was a boo-boo on my part, function returned the wrong variables.
#2 is a truncation problem which results in a higher-than-requested clock rate.
#3 became apparent when the MMC driver started requesting rate=0 during init.

Tony Prisk (3):
  clk: vt8500: Fix error in PLL calculations on non-exact match.
  clk: vt8500: Fix device clock divisor calculations
  clk: vt8500: Fix division-by-0 when requested rate=0

 drivers/clk/clk-vt8500.c |   28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

-- 
1.7.9.5
