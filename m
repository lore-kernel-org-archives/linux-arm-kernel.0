From: al.kochet@gmail.com (Alexander Kochetkov)
Date: Tue, 29 Nov 2016 15:15:15 +0300
Subject: [PATCH] clocksource/arm_global_timer: reconfigure clockevents after
 cpufreq change
Message-ID: <1480421716-30782-1-git-send-email-al.kochet@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

I found what arm-global-timer doesn't update clockevent's frequency
after cpufreq change. So I've backported two patches from
local-timer (smp_twd) to implement clockevent frequency adjustment.

Alexander Kochetkov (1):
  clocksource/arm_global_timer: reconfigure clockevents after cpufreq
    change

 drivers/clocksource/arm_global_timer.c |   93 +++++++++++++++++++++++++++++++-
 1 file changed, 92 insertions(+), 1 deletion(-)

-- 
1.7.9.5
