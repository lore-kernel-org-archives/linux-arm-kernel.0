From: wangkefeng.wang@huawei.com (Kefeng Wang)
Date: Sat, 28 May 2016 17:33:49 +0800
Subject: [PATCH 0/4] Support hisilicon 64bit mode timer  
Message-ID: <1464428033-52106-1-git-send-email-wangkefeng.wang@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

There is a kind of 64bit mode timer in hisilicon soc(like Hip05, Hip06 and
some arm32 soc), it is very similar with ARM sp804 Dual Timers, but TimerX
LOAD/Value/BGLoad are 64bit(two 32bit regs), and reg offset is different.

This patchset make some cleanup and enable 64bit mode timer for hisilicon.

Kefeng Wang (4):
  clocksource: sp804: cleanup clk_get_sys()
  clocksource: sp804: introduce helper sp804_load_mode_set()
  clocksource: sp804: use sp804_timer_disable() where possible
  clocksource: sp804: support 64bit mode for hisilicon timer64

 .../devicetree/bindings/timer/arm,sp804.txt        |   1 +
 drivers/clocksource/timer-sp.h                     |   1 +
 drivers/clocksource/timer-sp804.c                  | 142 +++++++++++++--------
 3 files changed, 92 insertions(+), 52 deletions(-)

-- 
1.7.12.4
