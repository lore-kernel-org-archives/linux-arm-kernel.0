From: jjhiblot@traphandler.com (Jean-Jacques Hiblot)
Date: Wed,  5 Feb 2014 09:37:34 +0100
Subject: [PATCH v2 0/4] clk: at91: better support for the PCKs
Message-ID: <1391589458-28018-1-git-send-email-jjhiblot@traphandler.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

This serie implements a better support for the Programmable Clocks.
The first two patch are related to changing the rate of the PCKs.
The 3rd patch is a fix to handle properly the PCKRDY interrupt.
The last patch is a small optimzation/simplification of the determine_rate
algorithm for the PCK.

This has been tested on a 9261ek

Boris BREZILLON (2):
  clk: at91: replace prog clk round_rate with determine_rate
  clk: at91: propagate rate change on system clks

Jean-Jacques Hiblot (2):
  clk: at91: fix programmable clk irq handling
  clk: at91: optimization of the determine_rate callback

 drivers/clk/at91/clk-programmable.c | 202 +++++++++++-------------------------
 drivers/clk/at91/clk-system.c       |  77 ++++++++++++--
 2 files changed, 127 insertions(+), 152 deletions(-)

-- 
1.8.5.2
