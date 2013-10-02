From: b.brezillon@overkiz.com (Boris BREZILLON)
Date: Wed,  2 Oct 2013 14:34:25 +0200
Subject: [PATCH 0/3] ARM: at91/tc/clocksource: various robustness improvements
Message-ID: <1380717265-6497-1-git-send-email-b.brezillon@overkiz.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This series include several improvements regarding the at91 tc clocksource
driver:
 - use clk_prepare/unprepare_enable/disable functions instead of the
   clk_enable/disable functions to prepare the transition to the common clk
   framework
 - check several function return values instead of considering these functions
   always suceed.
 - remove the deprecated IRQF_DISABLED flag

Best Regards,

Boris

Boris BREZILLON (3):
  ARM: at91/tc/clocksource: replace clk_enable/disable with
    clk_prepare_enable/disable_unprepare
  ARM: at91/tc/clocksource: improve driver robustness
  ARM: at91/tc/clocksource: remove IRQF_DISABLED

 drivers/clocksource/tcb_clksrc.c |   61 +++++++++++++++++++++++++++++++-------
 1 file changed, 50 insertions(+), 11 deletions(-)

-- 
1.7.9.5
