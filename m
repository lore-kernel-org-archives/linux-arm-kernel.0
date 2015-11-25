From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 25 Nov 2015 23:48:32 +0800
Subject: [PATCH v3 0/2] clocksource/drivers/dw_apb_timer: improve performance
 a bit
Message-ID: <1448466514-5298-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These two patches try to improve the dw_apb_timer clocksource/clockevent
performance.

since v2:
 - only use relaxed version in critical path
 - inline apbt_readl/apbt_writel
 - add some performance numbers

since v1:
 - correct the wrong sentence in commit msg about writel performance on
   CA9 with outer L2 cache. Thank Arnd for pointing out this in another
   thread.

Jisheng Zhang (2):
  clocksource/drivers/dw_apb_timer: Inline apbt_readl and apbt_writel
  clocksource/drivers/dw_apb_timer: Use {readl|writel}_relaxed in
    critical path

 drivers/clocksource/dw_apb_timer.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

-- 
2.6.2
