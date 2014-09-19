From: jszhang@marvell.com (Jisheng Zhang)
Date: Fri, 19 Sep 2014 14:29:57 +0800
Subject: [PATCH 0/2] watchdog: dw_wdt: one bug fix and restart handler support
Message-ID: <1411108199-1280-1-git-send-email-jszhang@marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

These patches are intend to improve dw_wdt in the following two aspects:

Firstly, the TOP_INIT may be zero at reset on some HW, so the timeout period
may be very short, thus we will see immediate system reset after openning 
the watchdog. Fix this problem by restarting the counter immediately after
WDT enabling.

Secondly, the WDT can also be used to reboot the system with the help of
recently introduced restart handler.

Tested on Marvell BG2Q DMP board.

Jisheng Zhang (2):
  watchdog: dw_wdt: restart the counter immediately after enabling WDT
  watchdog: dw_wdt: add restart handler support

 drivers/watchdog/dw_wdt.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

-- 
2.1.0
